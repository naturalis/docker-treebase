docker-treebase
====================

Docker compose file and docker file for running treebase 

Contents
-------------
Dockerfile creates the naturalis/treebase container which includes running tomcat + treebase code with entrypoint script mainly for modifying database connection details

docker-compose.yml uses the images:
- naturalis/treebase:0.0.1
- postgres
- traefik

No data is stored in the container, logging is mapped to /var/log/treebase  postgres database volume is persistent. 
tomcat runs on port 8080, traefik exposes this from port 443 using letsencrypt for certificates and redirects port 80 to 443

Instruction building image
-------------
No special instructions. 
```
docker build naturalis/treebase:0.0.1 .
```

Instruction running docker-compose.yml
-------------
Docker-compose.yml is used, environment variables for treebase container and docker-compose.yml can be defined in .env ( template .env.template ) traefik config in traefik.dev.toml


````
docker-compose up -d
````

Result
-------------

Working treebase webapplication.




