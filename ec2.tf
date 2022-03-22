resource "aws_instance" "web" {
  ami           = "ami-04893cdb768d0f9ee"
  instance_type = "t2.micro"

  tags = {
    Name = "Rakesh"
  }
}