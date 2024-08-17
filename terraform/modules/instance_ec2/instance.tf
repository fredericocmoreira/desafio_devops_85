resource "aws_key_pair" "ssh_pair_key" {
  key_name   = "frederico-key-pair"
  public_key = file("./modules/instance_ec2/id_rsa.pub")
}

resource "aws_instance" "devops_ec2" {
  ami                         = "ami-00402f0bdf4996822"
  instance_type               = "t3.medium"
  subnet_id                   = var.subnet_ec2_devops
  security_groups             = [aws_security_group.devops_ec2_sg.id]
  associate_public_ip_address = true
  # key_name                    = aws_key_pair.ssh_pair_key.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.id
  tags = merge(
    var.tags,
    {
      Name = "devops_instance"
    }
  )
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_role.id
}