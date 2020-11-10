provider "aws" {
region = "us-east-1"
}
resource "aws_instance" "test1" {
	ami = "ami-0a887e401f7654935"
	instance_type = "t2.micro"
	
	# the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
	
	# the VPC subnet
    subnet_id = aws_subnet.main-public-1.id
	# the public SSH key
  key_name = aws_key_pair.my_keypair1.key_name
	
	tags = {
    Name = "testing"
	}
}
  
  resource "aws_ebs_volume" "ebs-volume-1" {
  availability_zone = "us-east-1"
  size              = 5
  type              = "gp2"
  tags = {
    Name = "extra volume data"
  }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.ebs-volume-1.id
  instance_id = aws_instance.test1.id
}