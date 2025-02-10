#Project Configuration
stage = "poc"

#StackIT Provider Configuration
project_id     = "REPLACE_ME"
project_region = "eu01"

private_key_path         = "REPLACE_ME"
service_account_key_path = "REPLACE_ME"


#Bucket Configuration
bucket_name              = "demo-tfstate"
obs_credentials_group_id = "REPLACE_ME"


node_pools = [

  {
    availability_zones = ["eu01-2"]
    machine_type       = "c1.2"
    maximum            = 2
    minimum            = 1
    name               = "pool-infra"
    os_version_min     = "4081.2.0"

    labels = {
      "project" = "infrastructure"
    }

    taints = [
      {
        key    = "infrastructure"
        value  = "true"
        effect = "NoSchedule"
      }
    ]
  },


{%- for cluster in clusters %}
  {%- for nodepool in cluster.nodePools %}
  {
    availability_zones = {{ nodepool.availability_zones | default(["eu01-2"]) | tojson }},
    machine_type       = "{{ nodepool.machine_type | default('c1.2') }}",
    maximum            = {{ nodepool.maximum | default(2) }},
    minimum            = {{ nodepool.minimum | default(1) }},
    name               = "pool-{% if nodepool.name is defined and nodepool.name|length > 0 %}{{ nodepool.name }}{% else %}{{ cluster.project }}{% endif %}",
    os_version_min     = "{{ nodepool.os_version_min | default('4081.2.0') }}",

    labels = {
      {%- if nodepool.labels is defined and nodepool.labels|length > 0 %}
        {%- for key, value in nodepool.labels.items() %}
          "{{ key }}" = "{{ value }}"{% if not loop.last %}, {% endif %}
        {%- endfor %}
      {%- else %}
          "project" = "{{ cluster.project }}"
      {%- endif %}
    },

    taints = [
      {%- if nodepool.taints is defined and nodepool.taints|length > 0 %}
        {%- for taint in nodepool.taints %}
          {
            key    = "{{ taint.key }}",
            value  = "{{ taint.value }}",
            effect = "{{ taint.effect }}"
          }{% if not loop.last %}, {% endif %}
        {%- endfor %}
      {%- else %}
          {
            key    = "project",
            value  = "{{ cluster.project }}",
            effect = "NoSchedule"
          }
      {%- endif %}
    ]
  }{%- if not loop.last %}, {% endif %}
  {%- endfor %}
  {%- if not loop.last %}, {% endif %}
{%- endfor %}

]


#Tags
tags = {
  TF-Managed = "true"
}
