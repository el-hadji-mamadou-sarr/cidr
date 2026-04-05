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