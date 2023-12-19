resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier                = "pandora-${var.environment}-db"
  engine                            = "aurora-postgresql"
  engine_version                     = var.engine_version
  master_username                   = var.master_username
  master_password                   = var.master_password
  network_type                      = "IPV4"
  preferred_maintenance_window      = "mon:05:30-mon:06:30"
  backup_retention_period           = 35
  storage_encrypted                 = true
  kms_key_id                        = aws_kms_key.rds_kms_key.arn
  allow_major_version_upgrade       = true   
  deletion_protection               = true
  db_subnet_group_name              = "${aws_db_subnet_group.default.name}"
  db_instance_parameter_group_name  = "default.aurora-postgresql13"
  db_cluster_parameter_group_name   = "default.aurora-postgresql13"
  enabled_cloudwatch_logs_exports   = ["postgresql"]
}

resource "aws_rds_cluster_instance" "rds_instance" {
  count               = 2
  identifier          = "pandora-test-db-rds-${count.index == 0 ? "primary" : "reader"}"
  cluster_identifier  = aws_rds_cluster.rds_cluster.id 
  instance_class      = var.instance_class
  engine              = aws_rds_cluster.rds_cluster.engine
  engine_version      = aws_rds_cluster.rds_cluster.engine_version
}

resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet"
  subnet_ids =var.rds_subnet_ids


}

resource "aws_kms_key" "rds_kms_key" {
  description = "Example KMS Key"
}