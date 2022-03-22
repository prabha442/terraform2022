resource "aws_vpc" "myvpc" {
    cidr_block = "10.10.0.0/16"
    enable_dns_hostnames = true

    tags = {
        Name ="dev-vpc"
    }  
}

resource "aws_subnet" "pub-1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.10.10.0/24"
    availability_zone = "ap-south-1a"

        tags = {
          Name = "pub-1"
        }
    }
 resource "aws_subnet" "priv-1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.10.20.0/24"
    availability_zone = "ap-south-1b"

        tags = {
          Name = "priv-1"
        }
    }

 resource "aws_route_table" "pub-rtbl" {
     vpc_id = aws_vpc.myvpc.id

     route {
         cidr_block = "0.0.0.0/0"
         gateway_id = aws_internet_gateway.pub-igw.id
      }

      tags = {
        Name = "pub-sub-rtbl"
      }
   }

   resource "aws_route_table" "priv-rtbl" {
       vpc_id = aws_vpc.myvpc.id

       route  {
           cidr_block = "10.10.10.0/24"

       }

       tags = {
         Name = "priv-sub-rtbl"
       }
     
   }

   resource "aws_internet_gateway" "pub-igw" {
       vpc_id = aws_vpc.myvpc.id
     
     tags = {
       Name = "pub-igw"
     }
   }
    resource "aws_route_table_association" "pub-rtbl-asso" {
        subnet_id = aws_subnet.pub-1.id
        route_table_id = aws_route_table.pub-rtbl.id
      
    }