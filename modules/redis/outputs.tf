output "redis_endpoint" {
  description = "The DNS name of the Redis instance."
  value       = aws_elasticache_replication_group.redis_cluster.primary_endpoint_address
}

