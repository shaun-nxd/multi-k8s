docker build -t shaunhare/multi-client:latest -t shaunhare/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shaunhare/multi-server:latest -t shaunhare/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shaunhare/multi-worker:latest -t shaunhare/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shaunhare/multi-client:latest
docker push shaunhare/multi-server:latest
docker push shaunhare/multi-worker:latest

docker push shaunhare/multi-client:$SHA
docker push shaunhare/multi-server:$SHA
docker push shaunhare/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shaunhare/multi-server:$SHA
kubectl set image deployments/client-deployment client=shaunhare/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shaunhare/multi-worker:$SHA