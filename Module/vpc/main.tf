# Create VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

# Create Public Subnets
resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = element(var.availability_zones, count.index)

  tags = {
    Name = "fittbot-Dev-PublicSubnet-${count.index + 1}"
  }
}

# Create Private Subnets
resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "fittbot-Dev-PrivateSubnet-${count.index + 1}"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "fittbot-Dev-InternetGateway"
  }
}

# Create a Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "fittbot-Dev-PublicRouteTable"
  }
}

# Associate Public Subnets with Route Table
resource "aws_route_table_association" "public_assoc" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public.id
}
