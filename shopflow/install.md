kind create cluster --config shopflow/manifests/cluster-config.yml
istioctl install --set profile=demo -y    
kubectl apply -f istio-1.29.1/samples/addons/prometheus.yaml            
kubectl apply -f istio-1.29.1/samples/addons/grafana.yaml
kubectl apply -f istio-1.29.1/samples/addons/jaeger.yaml
kubectl rollout status deployment/prometheus -n istio-system 
kubectl rollout status deployment/grafana -n istio-system
kubectl rollout status deployment/jaeger -n istio-system
kubectl apply -k shopflow/manifests   

kubectl port-forward svc/istio-ingressgateway 8080:80 -n istio-system