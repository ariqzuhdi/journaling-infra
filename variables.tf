variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "ap-southeast-1"
}

variable "profile" {
  description = "The AWS profile to use"
  type        = string
  default     = "default"
}

variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-070a62b410fb866c0" # Replace with a valid AMI ID
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t4g.nano" # Replace with the desired instance
}

variable "instance_tag" {
  description = "The tag to assign to the instance"
  type        = string
  default     = "journaling-instance" # Replace with the desired tag
}

variable "key_name" {
  description = "The name of the key pair to use for the instance"
  type        = string
  default     = "journaling-key" # Replace with the desired key pair name
}