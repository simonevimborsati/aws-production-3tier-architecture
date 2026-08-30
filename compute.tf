# 1. Ricerca dinamica dell'AMI Ubuntu 22.04 LTS più recente
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# 2. Creazione dell'istanza EC2 nella prima Subnet Privata
resource "aws_instance" "app_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = module.vpc.private_subnets[0]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "web-app-backend"
  }
}

# 3. Collegamento (Attachment) dell'istanza EC2 al Target Group dell'ALB
resource "aws_lb_target_group_attachment" "app_attachment" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.app_server.id
  port             = 80
}