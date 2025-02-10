kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: rolebinding-admin
  namespace: vcluster-{{ cluster.project }}
roleRef:
  kind: ClusterRole
  name: admin
  apiGroup: rbac.authorization.k8s.io
subjects:
  - kind: Group
    name: "{{ cluster.ssoGroup }}"
    apiGroup: rbac.authorization.k8s.io
