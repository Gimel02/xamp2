#!/bin/bash

echo "Actualizando repositorio..."
git pull origin master

echo " Deteniendo contenedores..."
docker compose down

echo " Construyendo y levantando contenedores..."
docker compose up -d --build

echo " Despliegue terminado en http://localhost:8088"