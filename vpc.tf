# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "fittbot-Dev-VPC"
  }
}

# Create 3 Public Subnets
resource "aws_subnet" "public_subnets" {
  count = 3

  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.${count.index + 1}.0/24"
  map_public_ip_on_launch = true
  availability_zone       = element(["ap-south-2a", "ap-south-2b", "ap-south-2c"], count.index)

  tags = {
    Name = "fittbot-Dev-PublicSubnet-${count.index + 1}"
  }
}

# Create 3 Private Subnets
resource "aws_subnet" "private_subnets" {
  count = 3

  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index + 11}.0/22"
  availability_zone = element(["ap-south-2a", "ap-south-2b", "ap-south-2c"], count.index)

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

# Create a Route Table for Public Subnets
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
  count          = 3
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public.id
}
