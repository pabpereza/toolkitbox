#!/bin/bash
# Build orchestrator for ops-toolchain mega image
# This script dynamically discovers and bundles component installers
# into a unified Alpine-based Docker image.

set -e

# Configuration
BUILD_CONTEXT_DIR=".build-context"
COMPONENTS_DIR="components"
DOCKERFILE="Dockerfile.bundle"
IMAGE_NAME="toolkitbox/all:latest"

echo "=== Toolkitbox Builder ==="
echo "Starting dynamic component discovery..."

# Clean and recreate build context directory
if [ -d "$BUILD_CONTEXT_DIR" ]; then
    echo "Cleaning existing build context..."
    rm -rf "$BUILD_CONTEXT_DIR"
fi

mkdir -p "$BUILD_CONTEXT_DIR"
echo "Build context directory created: $BUILD_CONTEXT_DIR"

# Discover and collect component installers
component_count=0

if [ ! -d "$COMPONENTS_DIR" ]; then
    echo "ERROR: Components directory not found: $COMPONENTS_DIR"
    exit 1
fi

echo "Scanning for components in $COMPONENTS_DIR..."

# Iterate through each component directory
for component_path in "$COMPONENTS_DIR"/*; do
    if [ ! -d "$component_path" ]; then
        continue
    fi
    
    component_name=$(basename "$component_path")
    install_script="$component_path/install.sh"
    
    # Check if the component has an install.sh at root level
    if [ -f "$install_script" ]; then
        # Copy installer with component name to avoid collisions
        target_script="$BUILD_CONTEXT_DIR/${component_name}.sh"
        cp "$install_script" "$target_script"
        chmod u+x "$target_script"
        
        echo "  ✓ Found component: $component_name"
        component_count=$((component_count + 1))
    else
        echo "  ⊘ Skipping $component_name (no install.sh found)"
    fi
done

echo ""
echo "Component discovery complete: $component_count component(s) found"

if [ $component_count -eq 0 ]; then
    echo "WARNING: No components found to bundle"
fi

# Build the mega image
echo ""
echo "Building Docker image: $IMAGE_NAME"
echo "Using Dockerfile: $DOCKERFILE"
echo ""

docker build -f "$DOCKERFILE" -t "$IMAGE_NAME" .

echo ""
echo "=== Build Complete ==="
echo "Image: $IMAGE_NAME"
echo "Components bundled: $component_count"
