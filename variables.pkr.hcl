# variables.pkr.hcl

variable "instance_type" {
  description = "AMI Size"
  type        = string
  default     = "t2.micro"
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-west-2"
}