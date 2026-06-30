output "Jenkins_Public_IP" {

  value = aws_instance.jenkins_server.public_ip

}

output "Jenkins_URL" {

  value = "http://${aws_instance.jenkins_server.public_ip}:8080"

}