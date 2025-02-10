apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: vcluster-{{ cluster.project }}
  annotations:
    argocd.argoproj.io/sync-options: Prune=true
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  destination:
    name: ""
    namespace: vcluster-{{ cluster.project }}
    server: "https://kubernetes.default.svc"
  sources:
    - repoURL: https://github.com/la-cc/webinar-gitops-vcluster-kubernetes-platform.git
      path: vcluster/{{ cluster.project }}
      targetRevision: main
    - repoURL: https://github.com/la-cc/webinar-gitops-vcluster-kubernetes-platform.git
      targetRevision: main
      ref: valuesRepo
    - repoURL: https://github.com/la-cc/webinar-gitops-vcluster-kubernetes-platform.git
      targetRevision: main
      path: "./kubernetes-service-catalog/optimization/vcluster"
      helm:
        releaseName: "vcluster"
        valueFiles:
          - "values.yaml"
          - "$valuesRepo/vcluster/{{ cluster.project }}/helm/values.yaml"
  project: default
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      allowEmpty: true
    syncOptions:
      - CreateNamespace=false
      - PruneLast=true
      - PrunePropagationPolicy=foreground
      - ApplyOutOfSyncOnly=true
    retry:
        limit: 5
