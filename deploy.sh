docker build -t praskatti/multi-client:latest -t praskatti/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t praskatti/multi-server:latest -t praskatti/multi-server:$SHA - f ./server/Dockerfile ./server
docker build -t praskatti/multi-worker:latest -t praskatti/multi-worker:$SHA - f ./worker/Dockerfile ./worker

docker push praskatti/multi-client:$SHA
docker push praskatti/multi-server:$SHA
docker push praskatti/multi-worker:$SHA
docker push praskatti/multi-client:latest
docker push praskatti/multi-server:latest
docker push praskatti/multi-worker:latest

kubectl apply -f k8s/

kubectl set image deployments/server-deployment server=praskatti/multi-server:$SHA
kubectl set image deployments/client-deployment client=praskatti/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=praskatti/multi-worker:$SHA



