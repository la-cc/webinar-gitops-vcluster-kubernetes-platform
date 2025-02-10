apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: {{ cluster.project }}
  namespace: argocd
spec:
  description:  Project - {{ cluster.project }}
  clusterResourceWhitelist:
    - group: '*'
      kind: '*'
  destinations:
    - namespace: '*'
      server: '*'
  namespaceResourceWhitelist:
    - group: '*'
      kind: '*'
  sourceNamespaces:
    - '*'
  sourceRepos:
    - '*'