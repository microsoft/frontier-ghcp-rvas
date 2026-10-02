import assert from 'node:assert/strict';
import {
  cpSync, existsSync, lstatSync, mkdirSync, mkdtempSync, readFileSync,
  readdirSync, readlinkSync, rmSync, symlinkSync, unlinkSync, writeFileSync
} from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join, resolve } from 'node:path';
import { execFileSync, spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { stripVTControlCharacters } from 'node:util';
import test, { after } from 'node:test';

const root = resolve(dirname(fileURLToPath(import.meta.url)), '..');
const setup = readFileSync(join(root, 'scripts/setup-challenge.sh'), 'utf8');
const trackedFiles = execFileSync('git', ['ls-files'], { cwd: root, encoding: 'utf8' })
  .trim().split('\n');
const sourceFiles = [...new Set([...trackedFiles, 'scripts/setup-challenge.test.mjs'])];
const template = mkdtempSync(join(tmpdir(), 'participant-setup-template-'));
after(() => rmSync(template, { recursive: true, force: true }));

for (const file of sourceFiles) {
  const source = join(root, file);
  const target = join(template, file);
  mkdirSync(dirname(target), { recursive: true });
  if (lstatSync(source).isSymbolicLink()) {
    symlinkSync(readlinkSync(source), target);
  } else {
    cpSync(source, target);
  }
}
execFileSync('git', ['init', '--quiet'], { cwd: template });
execFileSync('git', ['remote', 'add', 'origin', '/template'], { cwd: template });

function mapping(name) {
  const block = setup.match(new RegExp(`declare -A ${name}=\\(([\\s\\S]*?)\\n\\)`))[1];
  return Object.fromEntries([...block.matchAll(/\[([^\]]+)\]="([^"]+)"/g)]
    .map(match => [match[1], match[2]]));
}

const challengeMap = mapping('CHALLENGE_MAP');
const trackMap = mapping('TRACK_FILE_MAP');
const marker = '.devcontainer/.workspace-prepared';
const removed = [
  'web', 'byoc', 'CONTRIBUTING.md', 'AGENTS.md', 'CONTEXT.md',
  'FACILITATOR_GUIDE.md', 'learning-paths.json', 'role-collections.json',
  'docs/index.md', 'docs/challenges', 'docs/tracks', 'docs/TROUBLESHOOTING.md',
  'scripts/setup-challenge.test.mjs', '.github/workflows', '.github/prompts'
];
const retained = [
  'LICENSE', 'CODE_OF_CONDUCT.md', 'SECURITY.md', 'TROUBLESHOOTING.md',
  'tracks/getting-started.md', 'docs/copilot-guide.md',
  'docs/prompt-engineering.md', 'docs/mcp-servers.md', '.vscode/mcp.json'
];
const runners = [
  { name: 'Bash', command: 'bash', args: key => ['scripts/setup-challenge.sh', key] },
  {
    name: 'PowerShell', command: 'pwsh',
    args: key => ['-NoLogo', '-NoProfile', '-File', 'scripts/setup-challenge.ps1', key],
    skip: spawnSync('pwsh', ['-NoLogo', '-NoProfile', '-Command', 'exit 0']).status !== 0
  }
];

function fixture(t) {
  const workspace = mkdtempSync(join(tmpdir(), 'participant-setup-fixture-'));
  t.after(() => rmSync(workspace, { recursive: true, force: true }));
  cpSync(template, workspace, { recursive: true, verbatimSymlinks: true });
  return workspace;
}

function run(runner, workspace, key) {
  return spawnSync(runner.command, runner.args(key), {
    cwd: workspace, encoding: 'utf8', timeout: 30_000
  });
}

function assertSuccess(result) {
  assert.equal(result.status, 0, `${result.error ?? ''}\n${result.stdout}\n${result.stderr}`);
}

function markdownLinks(file, workspace) {
  return [...readFileSync(join(workspace, file), 'utf8').matchAll(/\]\(([^)]+)\)/g)]
    .map(match => match[1].split('#')[0])
    .filter(target => target && !/^[a-z]+:/i.test(target))
    .map(target => resolve(workspace, dirname(file), target));
}

for (const runner of runners) {
  for (const [key, challenge] of Object.entries(challengeMap)) {
    test(`${runner.name}: ${key} cleanup and repeat setup`, { skip: runner.skip }, t => {
      const workspace = fixture(t);
      assertSuccess(run(runner, workspace, key));

      for (const file of removed) {
        assert(!existsSync(join(workspace, file)), `Unexpected leftover: ${file}`);
      }
      for (const file of retained) {
        assert.deepEqual(readFileSync(join(workspace, file)), readFileSync(join(root, file)));
      }
      assert.deepEqual(readdirSync(join(workspace, 'challenges')), [challenge]);
      assert.deepEqual(readdirSync(join(workspace, 'tracks')).sort(),
        ['getting-started.md', `${trackMap[key]}.md`, trackMap[key]].sort());
      assert.deepEqual(readdirSync(join(workspace, '.devcontainer')).sort(),
        ['.workspace-prepared', 'README.md', key].sort());
      assert.equal(readFileSync(join(workspace, marker), 'utf8'), `${key}\n`);
      assert.equal(readFileSync(join(workspace, '.github/copilot-instructions.md'), 'utf8'), '');
      assert.deepEqual(readdirSync(join(workspace, '.github/agents')), ['.gitkeep']);
      assert.deepEqual(readdirSync(join(workspace, '.github/skills')), ['.gitkeep']);
      assert.equal(execFileSync('git', ['remote'], { cwd: workspace, encoding: 'utf8' }), '');

      const starterFiles = trackedFiles.filter(file => file.startsWith(`challenges/${challenge}/`));
      for (const file of starterFiles) {
        assert.deepEqual(readFileSync(join(workspace, file)), readFileSync(join(root, file)));
      }
      const trackFiles = trackedFiles.filter(file =>
        file === `tracks/${trackMap[key]}.md` || file.startsWith(`tracks/${trackMap[key]}/`));
      for (const file of trackFiles) {
        assert.deepEqual(readFileSync(join(workspace, file)), readFileSync(join(root, file)));
        if (!file.endsWith('.md')) continue;
        for (const target of markdownLinks(file, root)) {
          if (!target.startsWith(`${root}/`) || !existsSync(target)) continue;
          assert(existsSync(join(workspace, target.slice(root.length + 1))),
            `Cleanup broke a link from ${file}: ${target}`);
        }
      }
      const readme = readFileSync(join(workspace, 'README.md'), 'utf8');
      assert.equal((readme.match(/\[Start your challenge\]/g) ?? []).length, 1);
      for (const target of markdownLinks('README.md', workspace)) {
        assert(existsSync(target), `Broken participant README link: ${target}`);
      }

      const participantFiles = [
        'README.md', 'AGENTS.md', '.github/copilot-instructions.md',
        '.github/agents/reviewer.agent.md', '.github/skills/impeccable/SKILL.md',
        '.github/skills/impeccable/engine/launcher', '.github/hooks/impeccable.json',
        '.impeccable/config.json', `challenges/${challenge}/participant.txt`,
        `tracks/${trackMap[key]}.md`
      ];
      for (const file of participantFiles) {
        mkdirSync(dirname(join(workspace, file)), { recursive: true });
        writeFileSync(join(workspace, file), 'participant content\n');
      }
      execFileSync('git', ['remote', 'add', 'origin', '/participant-owned'], { cwd: workspace });
      assertSuccess(run(runner, workspace, key));

      const otherKey = Object.keys(challengeMap).find(candidate => candidate !== key);
      const switched = run(runner, workspace, otherKey);
      assert.notEqual(switched.status, 0);
      const switchedOutput = stripVTControlCharacters(switched.stdout + switched.stderr)
        .replace(/\r?\n\s*\|\s*/g, ' ');
      assert.match(switchedOutput, /fresh\s+clone/);

      unlinkSync(join(workspace, marker));
      writeFileSync(join(workspace, 'FACILITATOR_GUIDE.md'), 'older workspace content\n');
      assertSuccess(run(runner, workspace, key));
      assert.equal(readFileSync(join(workspace, marker), 'utf8'), `${key}\n`);
      assert.equal(readFileSync(join(workspace, 'FACILITATOR_GUIDE.md'), 'utf8'),
        'older workspace content\n');
      for (const file of participantFiles) {
        assert.equal(readFileSync(join(workspace, file), 'utf8'), 'participant content\n');
      }
      assert.equal(execFileSync('git', ['remote', 'get-url', 'origin'], {
        cwd: workspace, encoding: 'utf8'
      }).trim(), '/participant-owned');
    });
  }

  test(`${runner.name}: invalid selection and missing files leave the template intact`,
    { skip: runner.skip }, t => {
      const workspace = fixture(t);
      const key = 'challenge-4-frontend';
      const initialInstructions = readFileSync(join(workspace, '.github/copilot-instructions.md'));
      assert.notEqual(run(runner, workspace, 'unknown-challenge').status, 0);
      unlinkSync(join(workspace, `tracks/${trackMap[key]}.md`));
      assert.notEqual(run(runner, workspace, key).status, 0);
      for (const file of ['web', 'byoc', 'CONTRIBUTING.md']) {
        assert(existsSync(join(workspace, file)));
      }
      assert(!existsSync(join(workspace, marker)));
      writeFileSync(join(workspace, marker), '');
      const emptyMarker = run(runner, workspace, key);
      assert.notEqual(emptyMarker.status, 0);
      assert.match(emptyMarker.stdout + emptyMarker.stderr, /invalid workspace marker/i);
      unlinkSync(join(workspace, marker));
      mkdirSync(join(workspace, marker));
      const directoryMarker = run(runner, workspace, key);
      assert.notEqual(directoryMarker.status, 0);
      assert.match(directoryMarker.stdout + directoryMarker.stderr, /invalid workspace marker/i);
      assert.deepEqual(readFileSync(join(workspace, '.github/copilot-instructions.md')),
        initialInstructions);
      assert.equal(execFileSync('git', ['remote', 'get-url', 'origin'], {
        cwd: workspace, encoding: 'utf8'
      }).trim(), '/template');
    });
}

const bash = execFileSync('bash', ['-c', 'command -v bash'], { encoding: 'utf8' }).trim();
for (const key of Object.keys(challengeMap)) {
  test(`${key}: container setup failure is not masked`, t => {
    const workspace = mkdtempSync(join(tmpdir(), 'participant-setup-command-'));
    t.after(() => rmSync(workspace, { recursive: true, force: true }));
    const bin = join(workspace, 'bin');
    mkdirSync(bin);
    writeFileSync(join(bin, 'bash'), '#!/bin/sh\nexit 23\n', { mode: 0o755 });
    const config = readFileSync(join(root, `.devcontainer/${key}/devcontainer.json`), 'utf8');
    const command = JSON.parse(config.match(/"postCreateCommand"\s*:\s*("(?:[^"\\]|\\.)*")/)[1]);
    const result = spawnSync(bash, ['-c', command], {
      cwd: workspace, env: { ...process.env, PATH: `${bin}:${process.env.PATH}` },
      encoding: 'utf8', timeout: 10_000
    });
    assert.equal(result.status, 23, `${result.stdout}\n${result.stderr}`);
  });
}
