resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    var.tags,
    {
      Name = "Pandora-${var.environment}-VPC"
    }
  )
}
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "Pandora-${var.environment}-Public-Route-Table"
    }
  )
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "Pandora-${var.environment}-Private-Route-Table"
    }
  )
}

resource "aws_subnet" "public_subnet" {
  count                  = length(var.availability_zones)
  vpc_id                 = aws_vpc.main.id
  cidr_block             = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  availability_zone      = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "Public-Subnet-${count.index + 1}${substr(var.availability_zones[count.index], - 1, 1)}"
    }
  )
}


resource "aws_subnet" "private_subnet" {
  count                  = length(var.availability_zones)
  vpc_id                 = aws_vpc.main.id
  cidr_block             = cidrsubnet(var.vpc_cidr_block, 8, count.index + 3)  # Start from the fourth /24 block
  availability_zone      = var.availability_zones[count.index]
  map_public_ip_on_launch = false
  tags = merge(
    var.tags,
    {
      Name = "Private-Subnet-${count.index + 1}${substr(var.availability_zones[count.index], - 1, 1)}"
    }
  )
}



resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "Pandora-${var.environment}-Internet-Gateway"
    }
  )
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.my_nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = merge(
    var.tags,
    {
      Name = "Pandora-${var.environment}-Nat-Gateway"
    }
  )
}

resource "aws_eip" "my_nat_eip" {}

resource "aws_route" "private_subnet_default_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}

resource "aws_route" "public_subnet_default_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "private_subnet_association" {
  count             = length(aws_subnet.private_subnet)
  subnet_id         = aws_subnet.private_subnet[count.index].id
  route_table_id    = aws_route_table.private_route_table.id
}
resource "aws_route_table_association" "public_subnet_association" {
  count             = length(aws_subnet.public_subnet)
  subnet_id         = aws_subnet.public_subnet[count.index].id
  route_table_id    = aws_route_table.public_route_table.id
}