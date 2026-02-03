# MariaDB Client

Cliente de línea de comandos para MariaDB/MySQL.

## Descripción

MariaDB Client (`mariadb` / `mysql`) es la herramienta de línea de comandos para conectarse a servidores MariaDB y MySQL. Permite ejecutar consultas SQL, administrar bases de datos, importar/exportar datos y gestionar usuarios.

## Instalación

Este componente instala `mariadb-client` desde los repositorios de Alpine Linux.

## Uso básico

### Conectar a un servidor
```bash
mariadb -h hostname -u usuario -p
```

### Conectar especificando base de datos
```bash
mariadb -h hostname -u usuario -p nombre_base_datos
```

### Ejecutar consulta directa
```bash
mariadb -h hostname -u usuario -p -e "SELECT * FROM tabla"
```

### Importar archivo SQL
```bash
mariadb -h hostname -u usuario -p base_datos < backup.sql
```

### Exportar base de datos (dump)
```bash
mariadb-dump -h hostname -u usuario -p base_datos > backup.sql
```

### Exportar solo estructura
```bash
mariadb-dump -h hostname -u usuario -p --no-data base_datos > schema.sql
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

## Ejemplo con Docker

```bash
docker run -it --rm \
  toolkitbox/mariadb \
  mariadb -h mi-servidor.com -u root -p
```

## Versiones legacy disponibles

- `v10.3` - MariaDB 10.3
- `v10.4` - MariaDB 10.4

## Documentación oficial

- [MariaDB Client](https://mariadb.com/kb/en/mariadb-command-line-client/)
- [mariadb-dump](https://mariadb.com/kb/en/mariadb-dump/)
