output "instance_id" {
  value = aws_instance.ubuntu_server.id
}

output "private_ip" {
  value = aws_instance.ubuntu_server.private_ip
}
