{% raw %}
apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: argocd
  namespace: argocd
  annotations:
    argocd.argoproj.io/sync-options: Prune=true
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  generators:
    - clusters:
        selector:
          matchLabels:
            env: vdev
        values:
          branch: main
  template:
    metadata:
      name: "{{name}}-argocd"
      annotations:
        argocd.argoproj.io/manifest-generate-paths: ".;.."
    spec:
      project: default
      sources:
        - repoURL: https://github.com/la-cc/webinar-gitops-vcluster-kubernetes-platform.git
          targetRevision: main
          ref: valuesRepo
        - repoURL: https://github.com/la-cc/webinar-gitops-vcluster-kubernetes-platform.git
          targetRevision: "{{values.branch}}"
          path: "./kubernetes-service-catalog/system/argocd"
          helm:
            releaseName: "argocd"
            valueFiles:
              - "values.yaml"
              - "$valuesRepo/vcluster/{{name}}/system/argocd/values.yaml"
      destination:
        name: "{{name}}"
        namespace: "argocd"
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
{% endraw %}