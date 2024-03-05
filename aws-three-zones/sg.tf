resource "aws_security_group" "allow-ssh-public" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-ssh-public"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["208.127.157.66/32"]
  }
  tags = {
    Name = "allow-ssh-public"
  }
}

resource "aws_security_group" "allow-ssh-private" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-ssh-private"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  ingress {
    from_port   = 443
    to_port     = 443 
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  tags = {
    Name = "allow-ssh-private"
  }
}
