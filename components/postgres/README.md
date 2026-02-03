# PostgreSQL Client

Cliente de línea de comandos para PostgreSQL.

## Descripción

PostgreSQL Client incluye `psql`, la herramienta interactiva de terminal para PostgreSQL, junto con utilidades adicionales como `pg_dump`, `pg_restore` y `pg_isready`. Permite ejecutar consultas SQL, gestionar bases de datos y realizar backups.

## Instalación

Este componente instala `postgresql-client` desde los repositorios de Alpine Linux.

## Uso básico

### Conectar a un servidor
```bash
psql -h hostname -U usuario -d base_datos
```

### Conectar usando URI
```bash
psql "postgresql://usuario:password@hostname:5432/base_datos"
```

### Ejecutar consulta directa
```bash
psql -h hostname -U usuario -d base_datos -c "SELECT * FROM tabla"
```

### Ejecutar script SQL
```bash
psql -h hostname -U usuario -d base_datos -f script.sql
```

### Exportar base de datos (backup)
```bash
pg_dump -h hostname -U usuario base_datos > backup.sql
```

### Exportar en formato personalizado (comprimido)
```bash
pg_dump -h hostname -U usuario -Fc base_datos > backup.dump
```

### Restaurar backup
```bash
pg_restore -h hostname -U usuario -d base_datos backup.dump
```

### Verificar conectividad
```bash
pg_isready -h hostname -p 5432
```

## Comandos útiles dentro de psql

```sql
-- Listar bases de datos
\l

-- Conectar a otra base de datos
\c nombre_base_datos

-- Listar tablas
\dt

-- Describir tabla
\d nombre_tabla

-- Listar usuarios
\du

-- Mostrar ayuda de comandos
\?

-- Ejecutar comando del sistema
\! ls -la

-- Salir
\q
```

## Opciones comunes

| Opción | Descripción |
|--------|-------------|
| `-h, --host` | Servidor al que conectar |
| `-p, --port` | Puerto (por defecto: 5432) |
| `-U, --username` | Usuario de conexión |
| `-d, --dbname` | Base de datos a seleccionar |
| `-c, --command` | Ejecutar comando SQL y salir |
| `-f, --file` | Ejecutar comandos desde archivo |
| `-W, --password` | Forzar solicitud de contraseña |

## Variables de entorno

| Variable | Descripción |
|----------|-------------|
| `PGHOST` | Host del servidor |
| `PGPORT` | Puerto del servidor |
| `PGUSER` | Usuario de conexión |
| `PGPASSWORD` | Contraseña (no recomendado en producción) |
| `PGDATABASE` | Base de datos por defecto |

## Ejemplo con Docker

```bash
docker run -it --rm \
  -e PGPASSWORD=mi_password \
  toolkitbox/postgres \
  psql -h mi-servidor.com -U postgres -d mi_base_datos
```

## Versiones legacy disponibles

- `v9.6` - PostgreSQL 9.6
- `v10` - PostgreSQL 10
- `v11` - PostgreSQL 11

## Documentación oficial

- [psql - PostgreSQL Interactive Terminal](https://www.postgresql.org/docs/current/app-psql.html)
- [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html)
- [pg_restore](https://www.postgresql.org/docs/current/app-pgrestore.html)
