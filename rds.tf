module "db" {
  source = "terraform-aws-modules/rds/aws"
  # DB-Namel
  identifier = var.identifier

  # Database-Features
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  port              = var.port
  multi_az          = true
  major_engine_version = "8.0"      # DB option group

  # Database-Credentia; 
  db_name  = var.db_name
  username = var.username
  password = var.password

  # Security-Group
  vpc_security_group_ids = [aws_security_group.db_instance_securityGroup.id]

  #Backup & maintainance 
  maintenance_window      = var.maintenance_window
  backup_window           = var.backup_window
  backup_retention_period = 0

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = module.vpc.private_subnets

  # DB parameter group
  family = var.family

  # Database Deletion Protection
  skip_final_snapshot = true
  deletion_protection = var.deletion_protection

  # Tags 
  tags = var.tags
}