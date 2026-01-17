#!/bin/bash
set -e

COMPONENT=$1
TAG=${2:-latest} # Default a latest si no se especifica

if [ -z "$COMPONENT" ]; then
    echo "Uso: ./build-single.sh <nombre-componente> [tag]"
    echo "Ejemplo: ./build-single.sh postgres v1.0"
    exit 1
fi

DIR="components/$COMPONENT"
SCRIPT="$DIR/install.sh"

if [ ! -f "$SCRIPT" ]; then
    echo "Error: No existe el componente '$COMPONENT' o no tiene install.sh"
    exit 1
fi

echo ">> Construyendo imagen individual para: $COMPONENT:$TAG"

# --- DYNAMIC TEMPLATE ---
# Usamos 'docker build -' para pasar el Dockerfile por stdin sin crear archivos
cat <<EOF | docker build -t "toolkitbox/$COMPONENT:$TAG" -f - "$DIR"
FROM alpine:latest
RUN apk add --no-cache bash curl ca-certificates

# Copiamos el script del contexto (la carpeta del componente)
COPY install.sh /tmp/install.sh

# Ejecutamos
RUN chmod u+x /tmp/install.sh && \\
    /tmp/install.sh && \\
    rm /tmp/install.sh

WORKDIR /root
CMD ["/bin/bash"]
EOF

echo ">> Imagen 'toolkitbox/$COMPONENT:$TAG' construida con éxito."