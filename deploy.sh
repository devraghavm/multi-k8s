docker build -t devraghavm/multi-client:latest -t devraghavm/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t devraghavm/multi-server:latest -t devraghavm/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t devraghavm/multi-worker:latest -t devraghavm/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push devraghavm/multi-client:latest
docker push devraghavm/mulit-server:latest
docker push devraghavm/multi-worker:latest

docker push devraghavm/multi-client:$SHA
docker push devraghavm/mulit-server:$SHA
docker push devraghavm/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=devraghavm/multi-server:$SHA
kubectl set image deployments/client-deployment client=devraghavm/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=devraghavm/multi-worker:$SHA
