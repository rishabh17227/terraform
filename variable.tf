variable "ec2_ami" {
  description = "Enter the DB engine"
  type        = string
  default     = "ami-0cff7528ff583bf9a"
}


variable "ec2_type" {
  description = "Enter the name of the database to be created inside DB Instance"
  type        = string
  default     = "t2.micro"
}

variable "ec2_name" {
  description = "Enter the username for DB"
  type        = list
  default     = ["instance1","instance2"]
}

variable "ec2_key" {
  description = "Enter the username for DB"
  type        = string
  default     = "linux"
}
