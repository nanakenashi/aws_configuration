provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "mockmock-vpc" {
  cidr_block = "10.0.0.0/16"
  tags {
    Name = "mockmock-vpc"
  }
}


resource "aws_subnet" "public-a" {
  vpc_id = "${aws_vpc.mockmock-vpc.id}"
  cidr_block = "10.0.0.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  tags {
    Name = "public-a"
  }
}

resource "aws_subnet" "public-b" {
  vpc_id = "${aws_vpc.mockmock-vpc.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  tags {
    Name = "public-b"
  }
}

resource "aws_subnet" "private-a" {
  vpc_id = "${aws_vpc.mockmock-vpc.id}"
  cidr_block = "10.0.8.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  tags {
    Name = "private-a"
  }
}

resource "aws_subnet" "private-b" {
  vpc_id = "${aws_vpc.mockmock-vpc.id}"
  cidr_block = "10.0.9.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[1]}"
  tags {
    Name = "private-b"
  }
}


resource "aws_internet_gateway" "mockmock-igw" {
  vpc_id = "${aws_vpc.mockmock-vpc.id}"
  tags {
    Name = "mockmock-igw"
  }
}


resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.mockmock-vpc.id}"
  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.mockmock-igw.id}"
  }
  tags {
    Name = "mockmock-public-table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.mockmock-vpc.id}"
  tags {
    Name = "mockmock-private-table"
  }
}


resource "aws_route_table_association" "public-a" {
  subnet_id = "${aws_subnet.public-a.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public-b" {
  subnet_id = "${aws_subnet.public-b.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private-a" {
  subnet_id = "${aws_subnet.private-a.id}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "private-b" {
  subnet_id = "${aws_subnet.private-b.id}"
  route_table_id = "${aws_route_table.private.id}"
}
