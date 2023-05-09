# create custom route table
resource "aws_route_table" "ap_route_table_01" {
  vpc_id = "${data.aws_vpc.vpc.id}"
}

# Route traffic to the NAT Gateway
resource "aws_route" "nat_gateway_route" {
  route_table_id = aws_route_table.ap_route_table_01.id
  destination_cidr_block = "10.0.0.0/16"
  nat_gateway_id = "${data.aws_nat_gateway.nat.id}"
}

# create new subnet
resource "aws_subnet" "ap_subnet" {
    vpc_id = "${data.aws_vpc.vpc.id}"
    cidr_block = "10.0.180.0/24"
    availability_zone = "ap-south-1c"
    tags = {
        Name = "ap_subnet"
    }
}

# associat subnet with route table
resource "aws_route_table_association" "associate_route_table_ap_subnet" {
  subnet_id = aws_subnet.ap_subnet.id
  route_table_id = aws_route_table.ap_route_table_01.id
}

# create security group
resource "aws_security_group" "ap_SecurityGroup" {
  name_prefix = "AP-SecurityGroup"

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${data.aws_vpc.vpc.id}"
}

# pushing lambda function
data "archive_file" "lambda" {
  type        = "zip"
  output_path = "${path.module}/aws.lambda.py.zip"
  source_file  = "${path.module}/lambda.py"
}

resource "aws_lambda_function" "ap_lambda" {
  function_name    = "andyphamlambda"
  role             = data.aws_iam_role.lambda.arn
  handler          = "lambda.invoke_restapi"
  runtime          = "python3.9"
  filename         = "${path.module}/aws.lambda.py.zip"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  vpc_config {
    subnet_ids = [aws_subnet.ap_subnet.id]
    security_group_ids = [aws_security_group.ap_SecurityGroup.id]
  }
}
