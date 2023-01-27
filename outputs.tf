output "checkly" {
  description = "The Checkly EC2 instance"
  value       = aws_instance.checkly.public_dns
}

output "webserver" {
  description = "The Webserver EC2 instance"
  value       = aws_instance.webserver.public_dns
}
