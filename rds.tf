resource "aws_db_subnet_group" "rds" {
  name = "rds"
  subnet_ids = [
    aws_subnet.subnet-1a.id,
    aws_subnet.subnet-1b.id
  ]
}

resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  identifier           = "mariadb"
  engine               = "mariadb"
  engine_version       = "10.6.11"
  instance_class       = "db.t4g.micro"
  username             = "administrator"
  password             = "password"
  parameter_group_name = "default.mariadb10.6"
  skip_final_snapshot  = true
  publicly_accessible  = false
  multi_az             = false
  db_subnet_group_name = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]
}
