#!/bin/bash
# Build script for individual bundles
# Usage: ./build-bundle.sh <bundle-name>
# Example: ./build-bundle.sh cloud

set -e

# Configuration
BUILD_CONTEXT_DIR=".build-context"
COMPONENTS_DIR="components"
BUNDLES_DIR="bundles"
DOCKERFILE="Dockerfile.bundle"

# Check arguments
if [ -z "$1" ]; then
    echo "ERROR: Bundle name required"
    echo "Usage: $0 <bundle-name>"
    echo ""
    echo "Available bundles:"
    for bundle_dir in "$BUNDLES_DIR"/*/; do
        if [ -d "$bundle_dir" ] && [ -f "${bundle_dir}components.txt" ]; then
            bundle_name=$(basename "$bundle_dir")
            echo "  - $bundle_name"
        fi
    done
    exit 1
fi

BUNDLE_NAME="$1"
BUNDLE_DIR="$BUNDLES_DIR/${BUNDLE_NAME}"
BUNDLE_FILE="$BUNDLE_DIR/components.txt"
IMAGE_NAME="toolkitbox/${BUNDLE_NAME}:latest"

# Validate bundle directory and components.txt exist
if [ ! -d "$BUNDLE_DIR" ]; then
    echo "ERROR: Bundle directory not found: $BUNDLE_DIR"
    exit 1
fi

if [ ! -f "$BUNDLE_FILE" ]; then
    echo "ERROR: Components file not found: $BUNDLE_FILE"
    exit 1
fi

echo "=== Toolkitbox Bundle Builder ==="
echo "Building bundle: $BUNDLE_NAME"
echo ""

# Clean and recreate build context directory
if [ -d "$BUILD_CONTEXT_DIR" ]; then
    rm -rf "$BUILD_CONTEXT_DIR"
fi
mkdir -p "$BUILD_CONTEXT_DIR"

# Read bundle file and collect components
component_count=0

echo "Reading bundle definition from $BUNDLE_FILE..."
while IFS= read -r line || [ -n "$line" ]; do
    # Skip empty lines and comments
    line=$(echo "$line" | xargs)  # Trim whitespace
    if [ -z "$line" ] || [[ "$line" == \#* ]]; then
        continue
    fi
    
    component_name="$line"
    install_script="$COMPONENTS_DIR/$component_name/install.sh"
    
    if [ -f "$install_script" ]; then
        target_script="$BUILD_CONTEXT_DIR/${component_name}.sh"
        cp "$install_script" "$target_script"
        chmod +x "$target_script"
        echo "  ✓ Added component: $component_name"
        component_count=$((component_count + 1))
    else
        echo "  ✗ Component not found: $component_name"
        echo "ERROR: Missing install.sh for component: $component_name"
        exit 1
    fi
done < "$BUNDLE_FILE"

echo ""
echo "Components to bundle: $component_count"

if [ $component_count -eq 0 ]; then
    echo "ERROR: No valid components found in bundle"
    exit 1
fi

# Build the bundle image
echo ""
echo "Building Docker image: $IMAGE_NAME"
docker build -f "$DOCKERFILE" -t "$IMAGE_NAME" .

echo ""
echo "=== Build Complete ==="
echo "Image: $IMAGE_NAME"
echo "Components bundled: $component_count"
