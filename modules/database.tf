resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "main-db-subnet-group"
  subnet_ids = module.vpc.database_subnets

  tags = {
    Name = "main-db-subnet-group"
  }
}

resource "aws_db_instance" "postgres_db" {
  allocated_storage      = 20
  max_allocated_storage  = 20                 
  engine                 = "postgres"
  engine_version         = "15"
  instance_class         = "db.t3.micro"       
  db_name                = "appdb"
  username               = var.db_username
  password               = var.db_password 
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true    
  publicly_accessible    = false
}