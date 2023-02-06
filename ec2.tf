# Prepare user_data for the checkly location
data "template_file" "checkly_user_data" {
  template = file("files/checkly.tpl")

  vars = {
    private_location_key = var.private_location_key
    rds_host             = aws_db_instance.rds.address
    rds_username         = "administrator"
    rds_password         = "password"
    redis_host           = aws_elasticache_cluster.redis.cache_nodes.0.address
  }
}

# Prepare user_data for the webserver
data "template_file" "webserver_user_data" {
  template = file("files/webserver.tpl")
}


# Create an EC2 instance to use as a Checkly location
resource "aws_instance" "checkly" {
  ami                    = "ami-0333305f9719618c7" # Ubuntu 22.04
  instance_type          = "t3.nano"
  key_name               = aws_key_pair.pem-key.key_name
  subnet_id              = aws_subnet.subnet-1a.id
  vpc_security_group_ids = [aws_security_group.webserver.id]

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = "10"
  }

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  tags = {
    Name = "Checkly"
  }

  user_data = data.template_file.checkly_user_data.rendered

}

# Create an EC2 instance to use as a Webserver
resource "aws_instance" "webserver" {
  ami                    = "ami-03d568a0c334477dd" # Ubuntu 22.04 ARM
  instance_type          = "t4g.nano"
  key_name               = aws_key_pair.pem-key.key_name
  subnet_id              = aws_subnet.subnet-1a.id
  vpc_security_group_ids = [aws_security_group.webserver.id]

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = "10"
  }

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  tags = {
    Name = "Webserver"
  }

  user_data = data.template_file.webserver_user_data.rendered

}
