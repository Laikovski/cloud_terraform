variable "ami_id" {
    description = "Amazon Linux 2"
    default     = "ami-076309742d466ad69"
}

variable "key_name" {
    description = " SSH keys to connect to ec2 instance"
    default     =  "pytest_server"
}

variable "bucket_prefix" {
    type        = string
    description = "(required since we are not using 'bucket') Creates a unique bucket name beginning with the specified prefix"
    default     = "my-s3bucket-"
}
variable "tag-ec2" {
    description = "(Optional) A mapping of tags to assign to the ec2."
    default     = {
        Name        = "remote-host"
        Terraform   = "true"
        Environment = "lab"
    }
}

variable "tags" {
    description = "(Optional) A mapping of tags to assign to the bucket."
    default     = {
        environment = "DEV"
        terraform   = "true"
    }
}