# Create your first development workspace

This tutorial creates a service workspace and connects it to the shared test
environment.

## Before you begin

Make sure Launchpad is installed globally.

## Create the workspace

1. Create a workspace named `orders`.

   ```bash
   launchpad workspace create orders --template service
   ```

2. Check that it is active.

   ```bash
   launchpad status orders
   ```

3. Install the repository dependencies.

   ```bash
   npm install
   ```

4. Run the generated setup commands.

   ```bash
   launchpad workspace apply orders
   ```

The workspace is ready when every check reports `green`.

See [Team vocabulary](../concepts/glossary.md) if the environment names are
unfamiliar.
