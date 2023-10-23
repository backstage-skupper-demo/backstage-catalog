#data "aws_security_group" "default" {
#  name = "default"
#}

resource "aws_instance" "skuppervm" {
  ami           = "ami-0c41531b8d18cc72b"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.skuppervm.key_name
  subnet_id     = aws_subnet.main.id

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "SkupperVM"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.skuppervm.private_key_openssh
    host        = "${self.public_ip}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install -y podman",
      "sudo setenforce 0",
      "sudo systemctl enable podman",
      "sudo systemctl start podman",
      "systemctl enable podman --user",
      "systemctl start podman --user",
      "podman run -p 8080:5050 -d docker.io/vad1mo/hello-world-rest:latest"
    ]

      
  }
}

resource "aws_key_pair" "skuppervm" {
  key_name   = "skupper vm"
  public_key = tls_private_key.skuppervm.public_key_openssh
}

resource "tls_private_key" "skuppervm" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Main"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "allow_ssh" {
  name = "allow_ssh"

  vpc_id = aws_vpc.main.id

  ingress {
    description   = "ssh from anywhere"
    from_port     = 22
    to_port       = 22
    protocol      = "tcp"
    cidr_blocks   = [ "0.0.0.0/0" ]
  }

  egress {
    description   = "all outbound allow"
    from_port     = 0
    to_port       = 0
    protocol      =  "-1"
    cidr_blocks   = [ "0.0.0.0/0" ]
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

#resource "aws_network_interface_sg_attachment" "sg_attachment" {
#  security_group_id    = aws_security_group.allow_ssh.id
#  network_interface_id = aws_instance.skuppervm.primary_network_interface_id
#}

resource "local_file" "ssh_key" {
  content         = tls_private_key.skuppervm.private_key_openssh
  filename        = "${path.module}/private_key"
  file_permission = "0600"
}

resource "local_file" "instance_ip" {
  content  = aws_instance.skuppervm.public_ip
  filename = "${path.module}/vm_ip"
}