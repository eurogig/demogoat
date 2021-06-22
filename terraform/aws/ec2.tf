resource "aws_instance" "web_host" {
  # ec2 have plain text secrets in user data
  ami           = "${var.ami}"
  instance_type = "t2.nano"

  vpc_security_group_ids = [
  "${aws_security_group.web-node.id}"]
  subnet_id = "${aws_subnet.web_subnet.id}"
  user_data = <<EOF
#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMAAA
export AWS_SECRET_ACCESS_KEY=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
export AWS_DEFAULT_REGION=us-west-2
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
EOF
  tags = {
    Name                 = "${local.resource_prefix.value}-ec2"
    git_commit           = "0468bf147ece4e3f9c72707c02c8bc19aa612071"
    git_file             = "terraform/aws/ec2.tf"
    git_last_modified_at = "2021-06-17 14:06:28"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "263c695e-c525-4b3a-a8ca-58bc6504cace"
  }
}

resource "aws_ebs_volume" "web_host_storage" {
  # unencrypted volume
  availability_zone = "${var.availability_zone}"
  #encrypted         = false  # Setting this causes the volume to be recreated on apply 
  size = 1
  tags = {
    Name                 = "${local.resource_prefix.value}-ebs"
    git_commit           = "0468bf147ece4e3f9c72707c02c8bc19aa612071"
    git_file             = "terraform/aws/ec2.tf"
    git_last_modified_at = "2021-06-17 14:06:28"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "048ea563-3dc2-4827-8dfe-551d5e18f655"
  }
}

resource "aws_ebs_snapshot" "example_snapshot" {
  # ebs snapshot without encryption
  volume_id   = "${aws_ebs_volume.web_host_storage.id}"
  description = "${local.resource_prefix.value}-ebs-snapshot"
  tags = {
    Name                 = "${local.resource_prefix.value}-ebs-snapshot"
    git_commit           = "0468bf147ece4e3f9c72707c02c8bc19aa612071"
    git_file             = "terraform/aws/ec2.tf"
    git_last_modified_at = "2021-06-17 14:06:28"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "94267f2c-2cfc-4d04-b497-9775116dd8ac"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.web_host_storage.id}"
  instance_id = "${aws_instance.web_host.id}"
}

resource "aws_security_group" "web-node" {
  # security group is open to the world in SSH port
  name        = "${local.resource_prefix.value}-sg"
  description = "${local.resource_prefix.value} Security Group"
  vpc_id      = aws_vpc.web_vpc.id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
  depends_on = [aws_vpc.web_vpc]
  tags = {
    git_commit           = "0468bf147ece4e3f9c72707c02c8bc19aa612071"
    git_file             = "terraform/aws/ec2.tf"
    git_last_modified_at = "2021-06-17 14:06:28"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "f80f45fe-2955-4a6c-935d-8c6275fc6ffa"
  }
}

resource "aws_vpc" "web_vpc" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name                 = "${local.resource_prefix.value}-vpc"
    git_commit           = "0468bf147ece4e3f9c72707c02c8bc19aa612071"
    git_file             = "terraform/aws/ec2.tf"
    git_last_modified_at = "2021-06-17 14:06:28"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "390a017f-8e8d-4ca5-97b0-80b7245c47b3"
  }
}

resource "aws_subnet" "web_subnet" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = "172.16.10.0/24"
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name                 = "${local.resource_prefix.value}-subnet"
    git_commit           = "0468bf147ece4e3f9c72707c02c8bc19aa612071"
    git_file             = "terraform/aws/ec2.tf"
    git_last_modified_at = "2021-06-17 14:06:28"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "89f6c3ba-af18-478e-a761-24ece6683100"
  }
}

resource "aws_subnet" "web_subnet2" {
  vpc_id                  = aws_vpc.web_vpc.id
  cidr_block              = "172.16.11.0/24"
  availability_zone       = var.availability_zone2
  map_public_ip_on_launch = true

  tags = {
    Name                 = "${local.resource_prefix.value}-subnet2"
    git_commit           = "0468bf147ece4e3f9c72707c02c8bc19aa612071"
    git_file             = "terraform/aws/ec2.tf"
    git_last_modified_at = "2021-06-17 14:06:28"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "2e3bbd42-179f-404f-b694-d0fdf9ac5f7f"
  }
}


resource "aws_internet_gateway" "web_igw" {
  vpc_id = aws_vpc.web_vpc.id

  tags = {
    Name                 = "${local.resource_prefix.value}-igw"
    git_commit           = "0468bf147ece4e3f9c72707c02c8bc19aa612071"
    git_file             = "terraform/aws/ec2.tf"
    git_last_modified_at = "2021-06-17 14:06:28"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "21aec81e-5695-4ea3-86aa-f6ae95216576"
  }
}

resource "aws_route_table" "web_rtb" {
  vpc_id = aws_vpc.web_vpc.id

  tags = {
    Name                 = "${local.resource_prefix.value}-rtb"
    git_commit           = "0468bf147ece4e3f9c72707c02c8bc19aa612071"
    git_file             = "terraform/aws/ec2.tf"
    git_last_modified_at = "2021-06-17 14:06:28"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "511593fd-ed32-4b97-b253-f1a5b0db579e"
  }
}

resource "aws_route_table_association" "rtbassoc" {
  subnet_id      = aws_subnet.web_subnet.id
  route_table_id = aws_route_table.web_rtb.id
}

resource "aws_route_table_association" "rtbassoc2" {
  subnet_id      = aws_subnet.web_subnet2.id
  route_table_id = aws_route_table.web_rtb.id
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.web_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.web_igw.id

  timeouts {
    create = "5m"
  }
}


resource "aws_network_interface" "web-eni" {
  subnet_id   = aws_subnet.web_subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name                 = "${local.resource_prefix.value}-primary_network_interface"
    git_commit           = "0468bf147ece4e3f9c72707c02c8bc19aa612071"
    git_file             = "terraform/aws/ec2.tf"
    git_last_modified_at = "2021-06-17 14:06:28"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "9b9d8999-3bc0-4c05-8246-0096187c1ca9"
  }
}

# VPC Flow Logs to S3
resource "aws_flow_log" "vpcflowlogs" {
  log_destination      = aws_s3_bucket.flowbucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.web_vpc.id

  tags = {
    Name                 = "${local.resource_prefix.value}-flowlogs"
    Environment          = local.resource_prefix.value
    git_commit           = "0468bf147ece4e3f9c72707c02c8bc19aa612071"
    git_file             = "terraform/aws/ec2.tf"
    git_last_modified_at = "2021-06-17 14:06:28"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "0465fd5e-7220-4fd5-93f4-178f858df706"
  }
}

resource "aws_s3_bucket" "flowbucket" {
  bucket        = "${local.resource_prefix.value}-flowlogs"
  force_destroy = true

  tags = {
    Name                 = "${local.resource_prefix.value}-flowlogs"
    Environment          = local.resource_prefix.value
    git_commit           = "0468bf147ece4e3f9c72707c02c8bc19aa612071"
    git_file             = "terraform/aws/ec2.tf"
    git_last_modified_at = "2021-06-17 14:06:28"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "a210c4ce-e183-48c3-9b83-72d8cac6fdd2"
  }
}

output "ec2_public_dns" {
  description = "Web Host Public DNS name"
  value       = aws_instance.web_host.public_dns
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.web_vpc.id
}

output "public_subnet" {
  description = "The ID of the Public subnet"
  value       = aws_subnet.web_subnet.id
}

output "public_subnet2" {
  description = "The ID of the Public subnet"
  value       = aws_subnet.web_subnet2.id
}
