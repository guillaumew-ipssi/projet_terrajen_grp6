
ingress {
                description = "rule add generated"
                from_port = <##PORT##>
                to_port = <##PORT##>
                protocol = "<##PROTOCOL##>"
                security_groups = ["${aws_security_group.<##SG_TEMPLATE##>.id}"]
        }