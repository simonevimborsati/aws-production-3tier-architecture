# 1. Security Group per l'Application Load Balancer
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Consente traffico HTTP in ingresso da Internet"
  vpc_id      = module.vpc.vpc_id

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Security Group per EC2
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Consente traffico HTTP in ingresso dal security group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. Security Group per PostgreSQL
resource "aws_security_group" "db_sg" {
  name        = "db-security-group"
  description = "Consente traffico PostgreSQL in ingresso da ec2"
  vpc_id      = module.vpc.vpc_id

  ingress {
    protocol  = "tcp"
    from_port = 5432
    to_port   = 5432
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# updated
