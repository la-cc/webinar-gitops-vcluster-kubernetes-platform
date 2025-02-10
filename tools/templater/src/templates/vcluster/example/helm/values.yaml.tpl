vcluster:
  sync:
    fromHost:
      nodes:
        enabled: false

  controlPlane:
    statefulSet:
      scheduling:
        nodeSelector:
          project: "{{ cluster.project }}"
        tolerations:
          - key: "project"
            operator: "Equal"
            value: "{{ cluster.project }}"
            effect: "NoSchedule"
      persistence:
        volumeClaim:
          enabled: true
          size: 5Gi
    backingStore:
      etcd:
        deploy:
          statefulSet:
            scheduling:
              nodeSelector:
                project: "{{ cluster.project }}"
              tolerations:
                - key: "project"
                  operator: "Equal"
                  value: "{{ cluster.project }}"
                  effect: "NoSchedule"

    coredns:
      enabled: true
      deployment:
        replicas: 1
        nodeSelector:
            project: "{{ cluster.project }}"
        tolerations:
          - key: "project"
            operator: "Equal"
            value: "{{ cluster.project }}"
            effect: "NoSchedule"



    distro:
      k3s:
        enabled: true
        image:
          repository: rancher/k3s
          tag: v1.31.1-k3s1



