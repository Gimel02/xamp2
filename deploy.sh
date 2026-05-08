#!/bin/bash

echo "Subiendo cambios a GitHub..."
git add .
git commit -m "Deploy automatico"
git push origin master

echo "Actualizando repositorio en la instancia..."

ssh -i ../Dock.key ubuntu@160.34.208.187 << 'EOF'
cd /home/ubuntu/xamp2

echo "Descargando cambios desde GitHub..."
git pull origin master

echo "Reconstruyendo contenedor..."
sudo docker-compose -f docker-compose.production.yml down
sudo docker-compose -f docker-compose.production.yml up -d --build --force-recreate

echo "Contenedores activos:"
sudo docker ps
EOF

echo "Levantando servidor local..."
nohup node server.js > app.log 2>&1 &

echo "Deploy terminado en http://160.34.208.187:8088"