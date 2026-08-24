# Set up your developer environment

The workspace utility configures everything needed for product development.
These steps apply to all engineers.

## Requirements

- Node.js 18
- npm 9
- Docker Desktop
- An administrator shell

## Install and verify

Clone the repository and run:

```bash
npm install
npm run compile
npm run launchpad -- workspace list
```

You should see the `service`, `frontend`, and `data` environments.

To prepare an environment:

```bash
npm run launchpad -- workspace create service --apply
```

The command installs required tools and writes machine configuration
automatically. Rerun it whenever the platform team changes the environment
definition.

For command details, see the [CLI reference](reference/cli.md).
