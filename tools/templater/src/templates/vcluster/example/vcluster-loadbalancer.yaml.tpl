apiVersion: v1
kind: Service
metadata:
  name: vcluster-loadbalancer
  namespace: vcluster-{{ cluster.project }}
spec:
  selector:
    app: vcluster
    release: vcluster
  ports:
    - name: https
      port: 443
      targetPort: 8443
      protocol: TCP
  type: LoadBalancer