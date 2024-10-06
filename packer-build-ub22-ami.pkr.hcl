# aws-ubuntu.pkr.hcl. Builds latest Ubuntu AMI

packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "ubuntu-ami" {
  ami_name      = "ubuntu-packer-aws-${local.timestamp}"
  instance_type = var.instance_type
  region        = var.aws_region
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ubuntu"
  tags = {
    "Name"        = "Ubuntu-jammy-22.04-Instance"
    "Environment" = "Dev"
    "OS_Version"  = "jammy-22.04"
    "Release"     = "Latest"
    "Created-by"  = "Packer"
  }
}
build {
  sources = ["source.amazon-ebs.ubuntu-ami"]

  provisioner "shell" {
    inline = [
      "cloud-init status --wait",
      "sudo apt-get update && sudo apt-get upgrade -y"
    ]
  }
}