# Historia Clinica de un Paciente y Receta Digital.

Proyecto de Ingeneriería de Software de Sistema de Clinica.

## Tecnologías:

### Frontend:
- Flutter.

### Backend:
- ASP.NET (C#) + Entity Framework Core + SQL Server.

## Entornos

- <b>DESARROLLO</b>:
    - Front:
        - Se siguiere usar Visual Studio Code + Extensiones.
    - Back:
        - db local: Si vas a desarrollar backend, se sugiere utilizar el compose de `clinica_back/Database/docker_compose.yml` para tener una base de datos local.
        - Se sugiere usar Visual Studio.

- <b>PRODUCCION</b>: Ambas aplicaciones tienen su `docker-compose.yml` para ser levantadas.

<b><i>IMPORTANTE!</i> -> SOLO UTILIZAR DOCKER PARA PRODUCCION, NO PARA DESARROLLAR (salvo la db local).</b>

## Arquitecturas

### Frontend
- Clean Architecture.

### Backend
- Microservicio orientado a DDD (Domain Driven Design) con capas 
    - Aplication Layer
    - Domain Layer
    - Infraestructure Layer
- BDD (Behaviour Driven design)

(NET Microservices Architecture for Containerized NET Applications - Pag 198)

## Comenzamos.

- El backend y el frontend no se pueden ejecutar con un mismo comando, son dos aplicaciones separadas.
- Idealmente se deben utilizar dos terminales.
- Para levantar el entorno de producción hay que colocarse en la carpeta de cada app `/clinica_back` o `/clinica_front` y correr los comandos `docker compose up --build` o `docker compose up`. 





