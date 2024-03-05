resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "vpc98"
  }
}

resource "aws_subnet" "public-subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/20"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-southeast-2a"

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private-subnet-a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.128.0/20"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-southeast-2a"

  tags = {
    Name = "private-subnet-a"
  }
}

resource "aws_subnet" "private-subnet-b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.144.0/20"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-southeast-2b"

  tags = {
    Name = "private-subnet-b"
  }
}

resource "aws_subnet" "private-subnet-c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.160.0/20"
  map_public_ip_on_launch = "false"
  availability_zone       = "ap-southeast-2c"

  tags = {
    Name = "private-subnet-c"
  }
}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "internet-gw"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }
}

resource "aws_route_table_association" "public-rta" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}
