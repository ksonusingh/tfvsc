locals {
  cidr_block = "192.168.1.0/24"
}

locals {
    db_instance = "10.0.32.50/32"
    inbound_ports = [80, 443, 22]
    outbound_rules = [{
      port = 443, 
      cidr_blocks = [ local.cidr_block ]
    },{
      

port = 1433,
      cidr_blocks = [ local.db_instance ]
    }]
}

#main body of VPC

resource "aws_vpc" "main" {
  cidr_block = local.cidr_block

  provider = aws.secondary
}

# Security Groups
resource "aws_security_group" "sg-webserver" {
    vpc_id              = aws_vpc.main.id
    name                = "webserver"
    description         = "Security Group for Web Servers"
    provider = aws.secondary

    dynamic "ingress" {
        for_each = local.inbound_ports
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = [local.cidr_block]
 
        }
    }

    dynamic "egress" {
        for_each = local.outbound_rules
        content {
            from_port = egress.value.port
            to_port = egress.value.port
            protocol = "tcp"
            cidr_blocks = egress.value.cidr_blocks
        }
    }
}