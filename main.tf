resource "aws_instance" "ec2" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_type
  count                       = length(var.ec2_name)
  subnet_id                   = data.aws_subnet.selected.id
  key_name                    = var.ec2_key
  security_groups             = [aws_security_group.new_sg01.id]
  associate_public_ip_address = true



  tags = {
    Name = var.ec2_name[count.index]
    # Name = var.ec2_name
  }
}

# resource "aws_key_pair" "tfkp" {
#   key_name   = "tfkp-key"
#   public_key = tls_private_key.rsa.public_key_openssh
# }

# resource "tls_private_key" "rsa" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "local_file" "tf-key" {
#     content  = tls_private_key.rsa.private_key_pem
#     filename = "tfkey"
# }

resource "aws_security_group" "new_sg01" {
  description = "internet access for public subnet"
  name        = "new_sg01"
  tags = {
    name = "new_sg01"
  }
  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    iterator = port
    for_each = var.egressrules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

