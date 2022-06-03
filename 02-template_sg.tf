
resource "aws_security_group" "<##INFRA_NAME##>-<##SG##>" {
        name ="<##INFRA_NAME##>-SG-WEB"
        description = "<##INFRA_NAME##>-SG-WEB"
        vpc_id = "${aws_vpc.<##INFRA_NAME##>-vpc.id}"

        <##INGRESS_RULES##>
        
        egress {
                description = "Allow out traffic"
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
                ipv6_cidr_blocks = []
        }
}