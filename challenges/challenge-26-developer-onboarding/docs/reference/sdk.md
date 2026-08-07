# JavaScript SDK reference

Import the environment client from the package root.

```typescript
import { loadWorkspace, setupCommands } from "launchpad-developer-tools";
```

## `loadWorkspace(name)`

Returns the named workspace. The promise rejects when the name does not exist.

```typescript
const workspace = await loadWorkspace("service");
console.log(workspace.requiredTools);
```

## `setupCommands(workspace, platform)`

Returns setup commands for `mac`, `windows`, or `linux`.

```typescript
const commands = setupCommands(workspace, "mac");
```

The SDK and CLI use the same environment definitions, although the SDK calls
them workspaces.

Return to the [documentation home](../index.md).
