docker volume create postgres_data

docker run -d \
  --name postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=postgres_db \
  -v postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:13

docker exec -i -t postgres-container bash

docker build -t simple-webapp-nodejs:latest .

docker run --name simple-webapp-nodejs --rm -p 8000:8000 -e DB_HOST=172.17.0.2 simple-webapp-nodejs

docker compose up -d 

docker compose down