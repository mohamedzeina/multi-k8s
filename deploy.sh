docker build -t toxiczeina/multi-client:latest -t toxiczeina/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t toxiczeina/multi-server:latest -t toxiczeina/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t toxiczeina/multi-worker:latest -t toxiczeina/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push toxiczeina/multi-client:latest
docker push toxiczeina/multi-server:latest
docker push toxiczeina/multi-worker:latest

docker push toxiczeina/multi-client:$SHA
docker push toxiczeina/multi-server:$SHA
docker push toxiczeina/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=toxiczeina/multi-server:$SHA
kubectl set image deployments/client-deployment client=toxiczeina/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=toxiczeina/multi-worker:$SHA
