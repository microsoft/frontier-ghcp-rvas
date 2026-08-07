# Workspace CLI reference

The `launchpad` command manages environment kits. Version 2.1 uses the
following command groups.

## `environment list`

Lists all available workspace templates.

```text
launchpad environment list [--format table|json]
```

## `environment get`

Shows one environment and its required tools.

```text
launchpad environment get <name> [--output json]
```

## `environment apply`

Installs an environment kit on the current machine.

```text
launchpad environment apply <name> [--confirm]
```

The command exits with code `0` even if an optional tool could not be
installed. Read standard output for warnings.

Return to the [documentation home](../index.md).
