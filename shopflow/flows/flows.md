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