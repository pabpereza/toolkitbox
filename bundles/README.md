# Bundles

This directory contains bundle definitions for grouping related tools into a single Docker image.

## Bundle Structure

Each bundle is defined in a directory with the following structure:

```text
bundles/
└── [bundle-name]/
    ├── components.txt    # List of components to include
    └── README.md         # Documentation (synced to Docker Hub)
```

### components.txt Format

```text
# Comment line (starts with #)
component-name-1
component-name-2
component-name-3
```

- Lines starting with `#` are comments and will be ignored
- Empty lines are ignored
- Each non-comment line should be the exact name of a component directory in `components/`

### README.md Format

The README.md file follows the same documentation standard as individual components and will be automatically synced to Docker Hub. See the [AGENTS.md](../AGENTS.md) for the complete documentation standard.

## Available Bundles

| Bundle | Description | Components |
|--------|-------------|------------|
| [cloud](cloud/) | Cloud provider CLI tools | aws-cli, azure-cli, gcloud |
| [databases](databases/) | Database client tools | postgres, mysql, mariadb, mongo, redis |

## Creating a New Bundle

1. Create a new directory in the `bundles/` folder:
   ```bash
   mkdir bundles/my-bundle
   ```

2. Create `components.txt` with the list of components:
   ```text
   # My Custom Bundle - Description
   component-1
   component-2
   ```

3. Create `README.md` following the documentation standard (see AGENTS.md).

4. The bundle will be automatically picked up by the `build-bundles.yml` workflow.

## Building Bundles

### Locally

```bash
./build-bundle.sh cloud
# Produces: toolkitbox/cloud:latest
```

### CI/CD

Bundles are automatically built by GitHub Actions when:
- Changes are pushed to the `bundles/` or `components/` directories
- Weekly scheduled builds run
- Manual workflow dispatch is triggered

Each bundle produces an image tagged as `toolkitbox/<bundle-name>:latest`.

## Docker Hub Sync

The `README.md` file of each bundle is automatically synced to Docker Hub when:
- Changes are pushed to `bundles/**/README.md`
- Manual workflow dispatch is triggered

This ensures that Docker Hub always has up-to-date documentation for each bundle image.
