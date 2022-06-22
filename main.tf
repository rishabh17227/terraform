resource "aws_instance" "ec2" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_type
  subnet_id                   = data.aws_subnet.selected.id
  key_name                    = var.ec2_key
  associate_public_ip_address = true
  security_groups             = [aws_security_group.public-sg-2.id]
  count                       = length(var.ec2_name)



  tags = {
    Name = var.ec2_name[count.index]
    # Name = var.ec2_name
  }
}


resource "aws_security_group" "public-sg-2" {
  description = "internet access for public subnet"
  name        = "public-sg-2"
  tags = {
    name = "public-sg-2"
  }
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
  }
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 443
    protocol  = "tcp"
    to_port   = 443
  }
  ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 3389
    protocol  = "tcp"
    to_port   = 3389
  }
  egress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 0
    protocol  = "-1"
    to_port   = 0
  }
}
