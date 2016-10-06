provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_eip" "ip" {
    instance = "${aws_instance.example.id}"
}

resource "aws_instance" "example" {
  ami           = "ami-ba3e14d9"
  instance_type = "t2.micro"
}

output "ip" {
    value = "${aws_eip.ip.public_ip}"
}
