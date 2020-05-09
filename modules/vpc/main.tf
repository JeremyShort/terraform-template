resource "aws_vpc" "tools-demo" {
	cidr_block = "10.200.200.0/24"
	}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.200.200.0/25"
}

variable "private_subnet_cidr" {
    description = "CIDR for the Private Subnet"
    default = "10.200.200.128/25"
}

resource "aws_internet_gateway" "tools-demo" {
    vpc_id = aws_vpc.tools-demo.id
}
