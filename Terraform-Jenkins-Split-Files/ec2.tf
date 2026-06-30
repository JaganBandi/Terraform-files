resource "aws_instance" "jenkins_server" {

  ami           = data.aws_ssm_parameter.amazon_linux_2023.value

  instance_type = "t3.small"

  key_name      = "Jump-Server"

  vpc_security_group_ids = [
    aws_security_group.jenkins_sg.id
  ]

  user_data = file("./jenkins.sh")

  tags = {
    Name = "Jenkins-Server"
  }
}