resource "stackit_ske_cluster" "ske" {
  name                   = "ske-${var.stage}" # not more than 11 chars
  project_id             = var.project_id
  kubernetes_version_min = var.kubernetes_version_min

  node_pools = var.node_pools
}