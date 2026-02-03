# Redis Client

Cliente de línea de comandos para Redis.

## Descripción

Redis CLI (`redis-cli`) es la herramienta oficial de línea de comandos para interactuar con servidores Redis. Permite ejecutar comandos Redis, gestionar claves, monitorear el servidor y realizar operaciones de administración.

## Instalación

Este componente instala `redis` (que incluye `redis-cli`) desde los repositorios de Alpine Linux.

## Uso básico

### Conectar a Redis local
```bash
redis-cli
```

### Conectar a servidor remoto
```bash
redis-cli -h hostname -p 6379
```

### Conectar con autenticación
```bash
redis-cli -h hostname -a password
```

### Conectar a Redis con TLS
```bash
redis-cli -h hostname --tls
```

### Ejecutar comando y salir
```bash
redis-cli -h hostname PING
```

### Ejecutar múltiples comandos desde archivo
```bash
redis-cli -h hostname < commands.txt
```

## Comandos útiles

### Operaciones con strings
```bash
# Establecer valor
SET clave "valor"

# Obtener valor
GET clave

# Establecer con expiración (segundos)
SETEX clave 3600 "valor"

# Incrementar contador
INCR contador
```

### Operaciones con listas
```bash
# Agregar a lista
LPUSH mi_lista "elemento"
RPUSH mi_lista "elemento"

# Obtener elementos
LRANGE mi_lista 0 -1

# Obtener longitud
LLEN mi_lista
```

### Operaciones con hashes
```bash
# Establecer campo
HSET usuario:1 nombre "Juan"

# Obtener campo
HGET usuario:1 nombre

# Obtener todos los campos
HGETALL usuario:1
```

### Operaciones con sets
```bash
# Agregar a set
SADD mi_set "elemento"

# Obtener miembros
SMEMBERS mi_set

# Verificar membresía
SISMEMBER mi_set "elemento"
```

### Administración
```bash
# Ver todas las claves
KEYS *

# Ver claves con patrón
KEYS user:*

# Información del servidor
INFO

# Monitor en tiempo real
MONITOR

# Ver clientes conectados
CLIENT LIST

# Obtener configuración
CONFIG GET maxmemory
```

## Opciones comunes

| Opción | Descripción |
|--------|-------------|
| `-h` | Hostname del servidor |
| `-p` | Puerto (por defecto: 6379) |
| `-a` | Contraseña de autenticación |
| `-n` | Número de base de datos (0-15) |
| `--tls` | Habilitar TLS |
| `--scan` | Usar SCAN en lugar de KEYS |
| `--bigkeys` | Buscar claves grandes |
| `--memkeys` | Analizar uso de memoria |

## Modos especiales

### Modo monitor
```bash
redis-cli MONITOR
```

### Modo pub/sub
```bash
# Suscribirse a canal
redis-cli SUBSCRIBE mi_canal

# Publicar mensaje
redis-cli PUBLISH mi_canal "mensaje"
```

### Análisis de claves
```bash
# Buscar claves grandes
redis-cli --bigkeys

# Analizar memoria
redis-cli --memkeys
```

## Ejemplo con Docker

```bash
docker run -it --rm \
  toolkitbox/redis \
  redis-cli -h mi-servidor.com -p 6379
```

## Versiones legacy disponibles

- `v4` - Redis 4.x
- `v5` - Redis 5.x

## Documentación oficial

- [Redis CLI](https://redis.io/docs/ui/cli/)
- [Redis Commands](https://redis.io/commands/)
