# MongoDB Client (mongosh)

Shell moderno de MongoDB para interactuar con bases de datos MongoDB.

## Descripción

`mongosh` es el shell oficial de MongoDB que reemplaza al antiguo `mongo` shell. Proporciona una interfaz de línea de comandos rica con autocompletado, resaltado de sintaxis y soporte completo para JavaScript.

## Instalación

Este componente descarga e instala `mongosh` directamente desde los binarios oficiales de MongoDB. Soporta arquitecturas x64 y arm64.

## Uso básico

### Conectar a MongoDB local
```bash
mongosh
```

### Conectar a servidor remoto
```bash
mongosh "mongodb://hostname:27017"
```

### Conectar con autenticación
```bash
mongosh "mongodb://usuario:password@hostname:27017/base_datos"
```

### Conectar a MongoDB Atlas
```bash
mongosh "mongodb+srv://cluster.mongodb.net/mydb" --username usuario
```

### Ejecutar comando y salir
```bash
mongosh --eval "db.getCollectionNames()"
```

### Ejecutar script JavaScript
```bash
mongosh script.js
```

## Comandos útiles dentro del shell

```javascript
// Mostrar bases de datos
show dbs

// Usar base de datos
use mi_base_datos

// Mostrar colecciones
show collections

// Buscar documentos
db.mi_coleccion.find()

// Insertar documento
db.mi_coleccion.insertOne({ nombre: "ejemplo" })

// Buscar con filtro
db.mi_coleccion.find({ campo: "valor" })

// Contar documentos
db.mi_coleccion.countDocuments()

// Crear índice
db.mi_coleccion.createIndex({ campo: 1 })
```

## Opciones de conexión

| Opción | Descripción |
|--------|-------------|
| `--host` | Servidor MongoDB |
| `--port` | Puerto (por defecto: 27017) |
| `--username` | Usuario de autenticación |
| `--password` | Contraseña |
| `--authenticationDatabase` | Base de datos de autenticación |
| `--eval` | Ejecutar expresión JavaScript |

## Ejemplo con Docker

```bash
docker run -it --rm \
  toolkitbox/mongo \
  mongosh "mongodb://mi-servidor:27017"
```

## Versiones legacy disponibles

- `v3.6` - MongoDB 3.6 (usa mongo shell clásico)
- `v4.4` - MongoDB 4.4 (usa mongo shell clásico)

## Documentación oficial

- [MongoDB Shell (mongosh)](https://www.mongodb.com/docs/mongodb-shell/)
- [CRUD Operations](https://www.mongodb.com/docs/mongodb-shell/crud/)
