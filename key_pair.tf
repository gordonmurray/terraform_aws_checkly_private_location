resource "aws_key_pair" "pem-key" {
  key_name   = "ec2-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
