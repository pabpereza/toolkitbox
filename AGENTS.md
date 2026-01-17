# Project Context & Architectural Standards

**Project Name:** Toolkitbox 

**Description:** Modular Docker image registry for DevOps/SysAdmin tools based on Alpine Linux.

**Architecture Pattern:** Dynamic Injection & Hybrid Assembly.

## 1. Core Philosophy

This repository operates on a **"Component-Based"** architecture to solve the dependency hell of monolithic Dockerfiles while allowing the creation of efficient bundles.

* **Modern Tools (Latest):** Defined via **Shell Scripts (`install.sh`)**. They are dynamically injected into a base `alpine:latest` image.
* **Legacy Tools (Old Versions):** Defined via **Standalone Dockerfiles**. They are isolated in their own containers to preserve old libraries (glibc/musl compatibility).

## 2. Directory Structure

All agents must strictly adhere to this hierarchy:

```text
ops-toolchain-assembly/
├── build-mega-image.sh          # Orchestrator for bundles (Do not modify logic without approval)
├── build-single.sh              # Builder for single components (Template based)
├── Dockerfile.bundle            # The generic template for the mega-image
├── components/                  # THE SOURCE OF TRUTH
│   ├── [tool-name]/             # Kebab-case naming (e.g., postgres-client)
│   │   ├── install.sh           # REQUIRED for modern versions.
│   │   └── [version]-legacy/    # OPTIONAL for legacy.
│   │       └── Dockerfile       # Standalone Dockerfile for legacy.

```

## 3. Development Rules (Strict)

### A. The `install.sh` Standard (For Latest Versions)

When asked to add a new tool, you must create a shell script, not a Dockerfile.

1. **Shebang:** Must be `#!/bin/sh` (Alpine standard).
2. **Error Handling:** Must start with `set -e`.
3. **Package Manager:** Use `apk add --no-cache`. Never leave cache files.
4. **Idempotency:** The script should assume it runs in a clean `alpine:latest` environment.
5. **Logging:** Include simple echo steps: `echo ">> Installing [Tool]..."`.

**Example:**

```bash
#!/bin/sh
set -e
echo ">> Installing Redis..."
apk add --no-cache redis

```

### B. The Legacy Standard (For Old Versions)

When asked to support an old version (e.g., MongoDB 3.6), do not use `install.sh`.

1. Create a subfolder: `components/[tool]/v[x]`.
2. Create a `Dockerfile`.
3. **Base Image:** Use a specific, frozen Alpine version (e.g., `FROM alpine:3.9`).
4. **Isolation:** This image will NOT be part of the Mega-Bundle.

### C. Build scripts

* **`build-allinone.sh`**: Scans `components/` for `install.sh` files, copies them to a build context, and builds `Dockerfile.bundle`.
* **`build-single.sh`**: Takes a component name, creates a dynamic Dockerfile on the fly injecting the specific `install.sh`, and builds a single image.

## 4. Workflows for Agents

**Scenario 1: "Add a new tool like Terraform"**

* Create directory `components/terraform/`.
* Create `components/terraform/install.sh`.
* Write the `apk add` or `wget` logic (for Alpine).
* Verify permissions (`chmod +x`).

**Scenario 2: "Update the PostgreSQL client"**

* Modify `components/postgres/install.sh`.
* Do NOT modify `Dockerfile.bundle`.

**Scenario 3: "Add support for an old Python 2 tool"**

* Create `components/python-tools/v2-legacy/Dockerfile`.
* Use `FROM python:2.7-alpine`.

## 5. Technical Constraints

* **OS Base:** Always `alpine` (unless strictly impossible, then `debian-slim` but warn user).
* **Shell:** Prefer `sh` over `bash` for installers to ensure portability.
* **User:** Operations run as `root` during build, but images may switch to non-root at the end if required by the tool.
