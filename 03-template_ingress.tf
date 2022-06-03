
ingress {
                description = "rule add generated"
                from_port = <##PORT##>
                to_port = <##PORT##>
                protocol = "<##PROTOCOL##>"
                cidr_blocks = ["<##SOURCE##>"]
        }