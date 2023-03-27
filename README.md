# openECOE Docker

Este proyecto es una aplicación basada en Docker.

## Requisitos

Para ejecutar esta aplicación, necesitarás tener Docker y Docker Compose instalados en tu máquina.

## Uso

Para ejecutar la aplicación, sigue los siguientes pasos:

1. Ejecuta el siguiente comando para iniciar la aplicación utilizando Docker Compose:

```
docker-compose up
```

Este comando iniciará los servicios definidos en el archivo docker-compose.yml (Redis, MySQL y la aplicación OpenECOE) en contenedores separados. También mapeará el puerto 8081 de tu máquina al puerto 80 de la aplicación.

2. Abre un navegador web y accede a la dirección `http://localhost:8081` para ver la aplicación en funcionamiento.

3. Para detener la aplicación, presiona `Ctrl+C` en la terminal donde se está ejecutando el comando `docker-compose up`. Esto detendrá los contenedores de la aplicación.

## Configuración

La aplicación se configura mediante variables de entorno. Puedes modificar estas variables para ajustar la configuración de la aplicación.

Las siguientes variables de entorno están definidas en el archivo docker-compose.yml:

- `OPENECOE_SECRET`: una clave secreta utilizada para firmar los tokens JWT utilizados en la autenticación.
- `OPENECOE_DB_HOST`: el nombre del host de la base de datos MySQL.
- `OPENECOE_DB_PORT`: el puerto de la base de datos MySQL.
- `OPENECOE_DB_USER`: el nombre de usuario para acceder a la base de datos MySQL.
- `OPENECOE_DB_PASSWORD`: la contraseña para acceder a la base de datos MySQL.
- `OPENECOE_DB_NAME`: el nombre de la base de datos MySQL que utiliza la aplicación.
- `OPENECOE_REDIS_HOST`: el nombre del host de Redis.
- `OPENECOE_REDIS_PORT`: el puerto de Redis.
- `OPENECOE_REDIS_DB`: la base de datos de Redis que utiliza la aplicación.
- `EMAIL`: el correo electrónico del usuario por defecto creado la primera vez que se inicia la aplicación.
- `PASSWORD`: la contraseña del usuario por defecto creado la primera vez que se inicia la aplicación.
- `FIRSTNAME`: el nombre del usuario por defecto creado la primera vez que se inicia la aplicación.
- `SURNAME`: el apellido del usuario por defecto creado la primera vez que se inicia la aplicación.
- `ORGANIZATION`: la organización del usuario por defecto creado la primera vez que se inicia la aplicación.
- `ALEMBIC_UPGRADE`: una marca utilizada para la actualización de la base de datos.
- `DEBUG`: una marca utilizada para activar o desactivar el modo de depuración.
- `LOG_TO_STDOUT`: una marca utilizada para activar o desactivar el registro de la salida estándar.

## Docker Hub

Esta imagen está disponible en Docker Hub. Puedes ejecutar la aplicación utilizando el siguiente comando:
```
docker-compose pull && docker-compose up
```

Esto descargará la imagen de Docker del repositorio de Docker Hub y ejecutará la aplicación utilizando Docker Compose.

## Contribución

Si deseas contribuir a este proyecto, por favor envía un pull request con tus cambios.

## Licencia

Este proyecto está bajo la licencia [nombre de la licencia]. Consulta el archivo LICENSE para más detalles.
