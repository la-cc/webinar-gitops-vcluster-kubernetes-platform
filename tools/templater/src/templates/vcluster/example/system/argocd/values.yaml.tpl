argo-cd:
  global:
    revisionHistoryLimit: 2
    tolerations:
      - key: "project"
        operator: "Equal"
        value: "{{ cluster.project }}"
        effect: "NoSchedule"

