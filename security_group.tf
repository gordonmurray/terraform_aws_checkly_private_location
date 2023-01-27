resource "aws_security_group" "webserver" {
  name        = "webserver"
  description = "webserver security group"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_security_group" "elasticache" {
  name        = "elasticache"
  description = "elasticache security group"
  vpc_id      = aws_vpc.vpc.id
}

resource "aws_security_group" "rds" {
  name        = "rds"
  description = "rds security group"
  vpc_id      = aws_vpc.vpc.id
}
