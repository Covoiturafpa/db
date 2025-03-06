@echo off
echo Stopping and removing containers...
docker-compose down

echo Starting containers...
docker-compose up -d

echo Current container status:
docker-compose ps


