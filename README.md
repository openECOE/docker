# Imagen oficial Docker openECOE

Servidor funcional openECOE [disponible en Docker Hub](https://hub.docker.com/r/openecoe/one-for-all)

Esta imagen esta diseñada para proporcionar un servicio con todos los componentes del proyecto openECOE unificados.

![openECOE](/img/openECOE.png)


## Requisitos

Para iniciar los servicios de este repositorio, necesitarás tener Docker y Docker Compose instalados en tu máquina.

También hace uso de los siguientes servicios:

- Base de datos [MySQL](https://www.mysql.com/) o [MariaDB](https://mariadb.org/) para la persistencia de datos
- Servidor [Redis](https://redis.com/) para la gestión de trabajos en segundo plano

## Como usar esta imagen

Para ejecutar la aplicación, sigue los siguientes pasos:

1. Ejecuta el siguiente comando para iniciar la aplicación utilizando Docker Compose:

```
docker-compose up
```

Este comando iniciará los servicios definidos en el archivo docker-compose.yml (Redis, MySQL y la aplicación OpenECOE) en contenedores separados. También mapeará el puerto 8081 de tu máquina al puerto 80 de la aplicación.


2. Abre un navegador web y accede a la dirección `http://localhost:8081` para ver la aplicación en funcionamiento 

> Puedes acceder con las siguientes credenciales:
> - Usuario: ecoe@umh.es
> - Contraseña: Kui0chee

3. Para detener la aplicación, presiona `Ctrl+C` en la terminal donde se está ejecutando el comando `docker-compose up`. Esto detendrá los contenedores de la aplicación.

### Ejemplo [docker-compose.yml](/docker-compose.yml)

Este fichero de docker compose crea los contenedores necesarios para poner en funcionamiento la openECOE con una configuración básica.

El fichero se utiliza de referencia y se debe adaptar según las necesidades.

```yml
version: '3'
services:
  redis:
    image: redis:latest
  db:
    image: mysql:latest
    environment:
      MYSQL_ROOT_PASSWORD: openecoe_1234
      MYSQL_DATABASE: openECOE
      MYSQL_USER: openecoe
      MYSQL_PASSWORD: openecoe_pass
    cap_add:
      - SYS_NICE
    healthcheck:
      test: "mysqladmin ping -p$$MYSQL_ROOT_PASSWORD"
      timeout: 5s
      retries: 3
  openecoe:
    build: 
      context: .
      dockerfile: Dockerfile
    image: openecoe/one-for-all:latest
    ports:
      - 8081:80
    environment:
      OPENECOE_SECRET: eiQuain4_aelohKa3_giGh6Fai_reeTh6Ai_Aegeic6l_ekuigo0M_aeph6Qua_uuZaac5n
      OPENECOE_DB_HOST: db
      OPENECOE_DB_PORT: 3306
      OPENECOE_DB_USER: openecoe
      OPENECOE_DB_PASSWORD: openecoe_pass
      OPENECOE_DB_NAME: openECOE
      OPENECOE_REDIS_HOST: redis
      OPENECOE_REDIS_PORT: 6379
      OPENECOE_REDIS_DB: 0
      
      # Usuario por defecto creado la primera vez
      EMAIL: ecoe@umh.es
      PASSWORD: Kui0chee
      FIRSTNAME: Open
      SURNAME: ECOE
      ORGANIZATION: UMH
      ALEMBIC_UPGRADE: DO

      # Configruación debug
      DEBUG: "False"
      LOG_TO_STDOUT: "False"
    depends_on:
      redis:
        condition: service_started
      db:
        condition: service_healthy
```

## Configuración

La aplicación se configura mediante variables de entorno. Puedes modificar estas variables para ajustar la configuración de la aplicación.

Las siguientes variables de entorno están definidas en el archivo docker-compose.yml
### General
- `OPENECOE_SECRET`: una clave secreta utilizada para firmar los tokens JWT utilizados en la autenticación.
- `OPENECOE_DB_HOST`: el nombre del host de la base de datos MySQL.
- `OPENECOE_DB_PORT`: el puerto de la base de datos MySQL.
- `OPENECOE_DB_USER`: el nombre de usuario para acceder a la base de datos MySQL.
- `OPENECOE_DB_PASSWORD`: la contraseña para acceder a la base de datos MySQL.
- `OPENECOE_DB_NAME`: el nombre de la base de datos MySQL que utiliza la aplicación.
- `OPENECOE_REDIS_HOST`: el nombre del host de Redis.
- `OPENECOE_REDIS_PORT`: el puerto de Redis.
- `OPENECOE_REDIS_DB`: la base de datos de Redis que utiliza la aplicación.
### Creación Usuario Inicial
- `EMAIL`: el correo electrónico del usuario por defecto creado la primera vez que se inicia la aplicación.
- `PASSWORD`: la contraseña del usuario por defecto creado la primera vez que se inicia la aplicación.
- `FIRSTNAME`: el nombre del usuario por defecto creado la primera vez que se inicia la aplicación.
- `SURNAME`: el apellido del usuario por defecto creado la primera vez que se inicia la aplicación.
- `ORGANIZATION`: la organización del usuario por defecto creado la primera vez que se inicia la aplicación.
- `ALEMBIC_UPGRADE`: una marca utilizada para la actualización de la base de datos.
### Depuración
- `DEBUG`: una marca utilizada para activar o desactivar el modo de depuración.
- `LOG_TO_STDOUT`: una marca utilizada para activar o desactivar el registro de la salida estándar.

## Docker Hub

Esta imagen está [disponible en Docker Hub](https://hub.docker.com/r/openecoe/one-for-all). Puedes ejecutar la aplicación utilizando el siguiente comando:
```
docker-compose pull && docker-compose up
```

Esto descargará la imagen de Docker del repositorio de Docker Hub y ejecutará la aplicación utilizando Docker Compose.

## Contribución

Si deseas contribuir a este proyecto, por favor envía un pull request con tus cambios.

## Licencia

Este proyecto está bajo la licencia GNU GPLv3. Consulta el archivo [LICENSE](/LICENSE) para más detalles.
