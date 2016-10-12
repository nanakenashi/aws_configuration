provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "mockmock-vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "PUBLIC-A" {
  vpc_id = "${aws_vpc.mockmock-vpc.id}"
  cidr_block = "10.0.0.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
}

resource "aws_subnet" "PUBLIC-B" {
  vpc_id = "${aws_vpc.mockmock-vpc.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
}

resource "aws_subnet" "PRIVATE-A" {
  vpc_id = "${aws_vpc.mockmock-vpc.id}"
  cidr_block = "10.0.8.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
}

resource "aws_subnet" "PRIVATE-B" {
  vpc_id = "${aws_vpc.mockmock-vpc.id}"
  cidr_block = "10.0.9.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
}
