# MySQL Client

Cliente de línea de comandos para MySQL.

## Descripción

MySQL Client (`mysql`) es la herramienta oficial de línea de comandos para conectarse a servidores MySQL. Permite ejecutar consultas SQL interactivas, scripts, y realizar tareas de administración de bases de datos.

## Instalación

Este componente instala `mysql-client` desde los repositorios de Alpine Linux.

## Uso básico

### Conectar a un servidor
```bash
mysql -h hostname -u usuario -p
```

### Conectar especificando base de datos
```bash
mysql -h hostname -u usuario -p nombre_base_datos
```

### Ejecutar consulta directa
```bash
mysql -h hostname -u usuario -p -e "SHOW DATABASES;"
```

### Importar archivo SQL
```bash
mysql -h hostname -u usuario -p base_datos < backup.sql
```

### Exportar base de datos
```bash
mysqldump -h hostname -u usuario -p base_datos > backup.sql
```

### Exportar todas las bases de datos
```bash
mysqldump -h hostname -u usuario -p --all-databases > full_backup.sql
```

### Exportar solo estructura (sin datos)
```bash
mysqldump -h hostname -u usuario -p --no-data base_datos > schema.sql
```

## Opciones comunes

| Opción | Descripción |
|--------|-------------|
| `-h, --host` | Servidor al que conectar |
| `-P, --port` | Puerto (por defecto: 3306) |
| `-u, --user` | Usuario de conexión |
| `-p, --password` | Solicitar contraseña |
| `-D, --database` | Base de datos a seleccionar |
| `-e, --execute` | Ejecutar comando y salir |
| `-N, --skip-column-names` | No mostrar nombres de columnas |
| `-B, --batch` | Modo batch (sin formato de tabla) |

## Comandos útiles dentro del cliente

```sql
-- Mostrar bases de datos
SHOW DATABASES;

-- Usar base de datos
USE nombre_base_datos;

-- Mostrar tablas
SHOW TABLES;

-- Describir estructura de tabla
DESCRIBE nombre_tabla;

-- Mostrar procesos activos
SHOW PROCESSLIST;

-- Ver variables del servidor
SHOW VARIABLES LIKE '%max_connections%';
```

## Ejemplo con Docker

```bash
docker run -it --rm \
  toolkitbox/mysql \
  mysql -h mi-servidor.com -u root -p
```

## Versiones legacy disponibles

- `v5.6` - MySQL 5.6
- `v5.7` - MySQL 5.7

## Documentación oficial

- [MySQL Command-Line Client](https://dev.mysql.com/doc/refman/8.0/en/mysql.html)
- [mysqldump](https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html)
