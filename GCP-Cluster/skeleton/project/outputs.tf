output "cluster_self_link" {
  value       = module.gke_cluster.cluster_self_link
  description = "The URI of the cluster."
}
output "node_pool_id" {
  value       = module.gke_cluster.node_pool_id
  description = "The id of the node pool."
}
