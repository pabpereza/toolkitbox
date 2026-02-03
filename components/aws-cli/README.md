# AWS CLI

Cliente de línea de comandos para Amazon Web Services.

## Descripción

AWS CLI es la herramienta oficial de Amazon para interactuar con todos los servicios de AWS desde la terminal. Permite gestionar recursos de EC2, S3, Lambda, RDS, y más de 200 servicios de AWS.

## Instalación

Este componente instala AWS CLI v2 desde los repositorios de Alpine Linux.

## Uso básico

### Configurar credenciales
```bash
aws configure
```

### Listar buckets de S3
```bash
aws s3 ls
```

### Listar instancias EC2
```bash
aws ec2 describe-instances
```

### Subir archivo a S3
```bash
aws s3 cp archivo.txt s3://mi-bucket/
```

### Sincronizar directorio con S3
```bash
aws s3 sync ./local-dir s3://mi-bucket/remote-dir
```

## Variables de entorno

| Variable | Descripción |
|----------|-------------|
| `AWS_ACCESS_KEY_ID` | ID de clave de acceso |
| `AWS_SECRET_ACCESS_KEY` | Clave secreta de acceso |
| `AWS_DEFAULT_REGION` | Región por defecto (ej: `eu-west-1`) |
| `AWS_PROFILE` | Perfil de configuración a usar |

## Ejemplo con Docker

```bash
docker run -it --rm \
  -e AWS_ACCESS_KEY_ID=tu_access_key \
  -e AWS_SECRET_ACCESS_KEY=tu_secret_key \
  -e AWS_DEFAULT_REGION=eu-west-1 \
  toolkitbox/aws-cli aws s3 ls
```

## Documentación oficial

- [AWS CLI Command Reference](https://docs.aws.amazon.com/cli/latest/reference/)
- [AWS CLI User Guide](https://docs.aws.amazon.com/cli/latest/userguide/)
