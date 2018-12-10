docker build -t charlesjlamb/multi-client:latest -t charlesjlamb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t charlesjlamb/multi-server:latest -t charlesjlamb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t charlesjlamb/multi-worker:latest -t charlesjlamb/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push charlesjlamb/multi-client:latest
docker push charlesjlamb/multi-server:latest
docker push charlesjlamb/multi-worker:latest
docker push charlesjlamb/multi-client:$SHA
docker push charlesjlamb/multi-server:$SHA
docker push charlesjlamb/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=charlesjlamb/multi-server:$SHA
kubectl set image deployments/client-deployment client=charlesjlamb/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=charlesjlamb/multi-worker:$SHA
