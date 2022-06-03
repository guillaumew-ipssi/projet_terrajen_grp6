
resource "aws_vpc" "<##INFRA_NAME##>-vpc" {
        cidr_block = "10.<##CLIENT_ID##>.0.0/16"
        tags = {
                Name = "<##INFRA_NAME##>-vpc"
        }
}
resource "aws_subnet" "<##INFRA_NAME##>-subadm" {
        vpc_id = "${aws_vpc.<##INFRA_NAME##>-vpc.id}"
        cidr_block = "10.<##CLIENT_ID##>.1.0/24"
        tags = {
                Name = "<##INFRA_NAME##>-subadm"
        }
}
resource "aws_subnet" "<##INFRA_NAME##>-priv1" {
        vpc_id = "${aws_vpc.<##INFRA_NAME##>-vpc.id}"
        cidr_block = "10.<##CLIENT_ID##>.2.0/24"
        availability_zone = "eu-west-3a"
        tags = {
                Name = "<##INFRA_NAME##>-priv1"
        }
}
resource "aws_subnet" "<##INFRA_NAME##>-priv2" {
        vpc_id = "${aws_vpc.<##INFRA_NAME##>-vpc.id}"
        cidr_block = "10.<##CLIENT_ID##>.3.0/24"
        availability_zone = "eu-west-3b"
        tags = {
                Name = "<##INFRA_NAME##>-priv2"
        }
}
resource "aws_subnet" "<##INFRA_NAME##>-priv3" {
        vpc_id = "${aws_vpc.<##INFRA_NAME##>-vpc.id}"
        cidr_block = "10.<##CLIENT_ID##>.4.0/24"
        availability_zone = "eu-west-3c"
        tags = {
                Name = "<##INFRA_NAME##>-priv3"
        }
}
resource "aws_internet_gateway" "<##INFRA_NAME##>-igw" {
        vpc_id = "${aws_vpc.<##INFRA_NAME##>-vpc.id}"
        tags = {
                Name = "<##INFRA_NAME##>-igw"
        }
}
resource "aws_eip" "<##INFRA_NAME##>-nateip" {
}
resource "aws_nat_gateway" "<##INFRA_NAME##>-natgw" {
        subnet_id = "${aws_subnet.<##INFRA_NAME##>-subadm.id}"
        allocation_id = "${aws_eip.<##INFRA_NAME##>-nateip.id}"
        tags = {
                Name = "<##INFRA_NAME##>-natgw"
        }
}
resource "aws_route" "<##INFRA_NAME##>-defroute" {
        route_table_id = "${aws_vpc.<##INFRA_NAME##>-vpc.default_route_table_id}"
        destination_cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.<##INFRA_NAME##>-igw.id}"
}
resource "aws_route_table" "<##INFRA_NAME##>-privrtb" {
        vpc_id = "${aws_vpc.<##INFRA_NAME##>-vpc.id}"
        route {
                cidr_block = "0.0.0.0/0"
                nat_gateway_id = "${aws_nat_gateway.<##INFRA_NAME##>-natgw.id}"
        }
}
resource "aws_route_table_association" "<##INFRA_NAME##>-privrtb-assoc1" {
        route_table_id = "${aws_route_table.<##INFRA_NAME##>-privrtb.id}"
        subnet_id = "${aws_subnet.<##INFRA_NAME##>-priv1.id}"
}
resource "aws_route_table_association" "<##INFRA_NAME##>-privrtb-assoc2" {
        route_table_id = "${aws_route_table.<##INFRA_NAME##>-privrtb.id}"
        subnet_id = "${aws_subnet.<##INFRA_NAME##>-priv2.id}"
}
resource "aws_route_table_association" "<##INFRA_NAME##>-privrtb-assoc3" {
        route_table_id = "${aws_route_table.<##INFRA_NAME##>-privrtb.id}"
        subnet_id = "${aws_subnet.<##INFRA_NAME##>-priv3.id}"
}