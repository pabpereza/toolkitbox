# Bundles

This directory contains bundle definitions for grouping related tools into a single Docker image.

## Bundle Format

Each bundle is defined in a `.txt` file with the following format:

```text
# Comment line (starts with #)
component-name-1
component-name-2
component-name-3
```

- Lines starting with `#` are comments and will be ignored
- Empty lines are ignored
- Each non-comment line should be the exact name of a component directory in `components/`

## Available Bundles

| Bundle | Description | Components |
|--------|-------------|------------|
| cloud | Cloud provider CLI tools | aws-cli, azure-cli, gcloud |
| databases | Database client tools | postgres, mysql, mariadb, mongo, redis |

## Creating a New Bundle

1. Create a new `.txt` file in the `bundles/` directory:
   ```bash
   touch bundles/my-bundle.txt
   ```

2. Add component names (one per line):
   ```text
   # My Custom Bundle - Description
   component-1
   component-2
   ```

3. The bundle will be automatically picked up by the `build-bundles.yml` workflow.

## Building Bundles

Bundles are automatically built by GitHub Actions when:
- Changes are pushed to the `bundles/` or `components/` directories
- Weekly scheduled builds run
- Manual workflow dispatch is triggered

Each bundle produces an image tagged as `toolkitbox/<bundle-name>:latest`.
