curl fails to reach service
          │
          ▼
  kubectl get endpoints → <none>?
          │
          ├── YES → selector mismatch
          │         kubectl describe service → check selector
          │         kubectl get pods --show-labels → check pod labels
          │
          └── NO → endpoints exist, problem is elsewhere
                   (pod crashing, wrong port, network policy...)

# Statefull set
1. Stable name
    Deployment pod: product-service-7d9f8b-xk2p9  (random suffix, changes)
    StatefulSet pod: postgres-0                     (always postgres-0)
                    postgres-1                     (always postgres-1)

2. Stable storage
    Each pod gets its own PersistentVolume that follows it.
    postgres-0 always mounts its own volume, not a shared one.
    Pod restarts → same volume reattaches → data survives.
    postgres-0
        PVC: data-0 (its own disk)
    postgres-1
        PVC: data-1 (its own disk)
    
    pod dies same PVC reattached, data is never lost

3. Ordered startup/shutdown
    postgres-0 starts first and must be Ready before postgres-1 starts.
    Shutdown happens in reverse order.
    Critical for primary/replica database setups.

# Iptables

Inbound traffic:

  External request → pod IP:8080
                          │
                    iptables rule #1:
                    "intercept all inbound traffic
                     redirect to Envoy at :15006"
                          │
                          ▼
                    Envoy (:15006)
                    - records the request
                    - applies policies
                    - checks mTLS certificate
                          │
                          ▼
                    your app (:8080)
                    "I just got a normal request"
                    (has no idea Envoy exists)


  Outbound traffic:

  your app → tries to connect to postgres:5432
                          │
                    iptables rule #2:
                    "intercept all outbound traffic
                     redirect to Envoy at :15001"
                          │
                          ▼
                    Envoy (:15001)
                    - records the outbound call
                    - applies retry/timeout rules
                    - encrypts with mTLS
                          │
                          ▼
                    actual postgres pod

# See all the upstream services Envoy knows about
istioctl proxy-config clusters <pod-name> -n shopflow-dev

# See the listeners (what ports Envoy is watching)
istioctl proxy-config listeners <pod-name> -n shopflow-dev

# See the routes
istioctl proxy-config routes <pod-name> -n shopflow-dev

Layer 1 — NodePort / LoadBalancer
  "how does traffic get INTO the cluster nodes?"
  This is a Kubernetes concept.

  Layer 2 — Ingress / IngressController  
  "how does HTTP traffic get routed to the right service?"
  This is also a Kubernetes concept.

  Layer 3 — Istio Gateway + VirtualService
  "how does Istio control traffic after it enters?"
  This is an Istio concept.