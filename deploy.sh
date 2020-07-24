docker build -t axmlr/multi-client:latest -t axmlr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t axmlr/multi-server:latest -t axmlr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t axmlr/multi-worker:latest -t axmlr/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push axmlr/multi-client:latest 
docker push axmlr/multi-client:$SHA 
docker push axmlr/multi-server:latest 
docker push axmlr/multi-server:$SHA 
docker push axmlr/multi-worker:latest 
docker push axmlr/multi-worker:$SHA 
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=axmlr/multi-server:$SHA
kubectl set image deployments/client-deployment client=axmlr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=axmlr/multi-worker:$SHA