output "cluster_self_link" {
  value       = google_container_cluster.primary.self_link
  description = "The URI of the cluster."
}
output "node_pool_id" {
  value       = google_container_cluster.primary.id
  description = "The id of the node pool."
}
