resource "aws_elasticache_replication_group" "redis_cluster" {
  replication_group_id       = var.replication_group_id
  description                = "Pandora-Redis-Cluster"
  engine                     = "redis"
  node_type                  = "cache.t3.micro"
  parameter_group_name       = "default.redis6.x"
  engine_version             = "6.2"
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  automatic_failover_enabled = true
  apply_immediately          = var.apply_immediately
  multi_az_enabled           = true
  ip_discovery               = "ipv4"
  num_cache_clusters         = 3
  port                       = 6379
  maintenance_window         = "mon:05:30-mon:06:30"
  network_type               = "ipv4"
  snapshot_window            = "23:00-00:00"
  snapshot_retention_limit   = 35





  log_delivery_configuration {
    destination      = "redis"
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }
  

  
  
  log_delivery_configuration {
    destination      = "redis"
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }
}

resource "aws_elasticache_subnet_group" "redis_subnet" {
  name       = "redis-subnet"
  subnet_ids = var.redis_subnet_ids
}
