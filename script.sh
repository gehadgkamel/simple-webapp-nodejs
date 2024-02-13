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

kubectl create deployment simple-webapp-nodejs --image=gehadgkamel/simple-webapp-nodejs:latest --replicas=1 --dry-run=client -o yaml > Infrastructure/manifests/simple-webapp-nodejs-deployment.yaml

kubectl expose deployment simple-webapp-nodejs --type=ClusterIP --port=80 --target-port=8000 --dry-run=client -o yaml > Infrastructure/manifests/simple-webapp-nodejs-service.yaml

kubectl create ingress simple-webapp-nodejs --rule="myapp.example.com/*=simple-webapp-nodejs:80" --dry-run=client -o yaml > Infrastructure/manifests/simple-webapp-nodejs-ingress.yaml

aws eks update-kubeconfig --name ex-terraform --region us-east-1
