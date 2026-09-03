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

# 2. Creazione delle istanze EC2 nelle Subnet Private (1 per ogni AZ)
resource "aws_instance" "app_server" {
  count                  = length(module.vpc.private_subnets)
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = module.vpc.private_subnets[count.index]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "web-app-backend-${count.index + 1}"
  }
}

# 3. Collegamento (Attachment) di tutte le istanze EC2 al Target Group dell'ALB
resource "aws_lb_target_group_attachment" "app_attachment" {
  count            = length(aws_instance.app_server)
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.app_server[count.index].id
  port             = 80
}
