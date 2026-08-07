import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";
import { parse } from "yaml";
import { inspectContract, runChecks } from "../scripts/check-contracts.js";

const rules = JSON.parse(await readFile(new URL("../standards/draft-rules.json", import.meta.url), "utf8"));

test("starter contracts expose several governance conflicts", async () => {
  const { files, findings } = await runChecks();
  assert.equal(files.length, 3);
  assert.ok(findings.length >= 12);

  const representedRules = new Set(findings.map(finding => finding.rule));
  for (const rule of [
    "versioning.info",
    "versioning.path",
    "naming.operationId",
    "naming.property",
    "pagination.query",
    "errors.mediaType",
    "identity.scheme",
    "observability.correlation"
  ]) {
    assert.ok(representedRules.has(rule), `Expected baseline finding for ${rule}`);
  }
});

test("a normalized operation can pass the draft rules", () => {
  const document = parse(`
openapi: 3.0.3
info:
  title: Example
  version: 1.0.0
servers:
  - url: https://api.example.test/v1
security:
  - entra: []
paths:
  /widgets:
    get:
      operationId: listWidgets
      parameters:
        - name: cursor
          in: query
          schema:
            type: string
        - name: limit
          in: query
          schema:
            type: integer
        - name: x-correlation-id
          in: header
          schema:
            type: string
      responses:
        "200":
          description: OK
        "400":
          description: Problem
          content:
            application/problem+json:
              schema:
                type: object
                required: [type, title, status]
                properties:
                  type: { type: string }
                  title: { type: string }
                  status: { type: integer }
components:
  securitySchemes:
    entra:
      type: openIdConnect
      openIdConnectUrl: https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration
`);

  assert.deepEqual(inspectContract(document, "normalized.yaml", rules), []);
});
