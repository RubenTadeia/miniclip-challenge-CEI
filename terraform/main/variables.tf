## 
# Variables

variable "environment_name" {
    type = string
}

variable "ami_name" {
    type = string
}

variable "server_name" {
    type = string
}

variable "first_script" {
    type = string
}

variable "bucket_name" {
    type = string
}

variable "index_document_to_be_deployed" {
    type = string
}

variable "error_file_to_be_deployed" {
    type = string
}

variable "loadbalancer_name" {
    type = string
}

variable "auto_scaling_group_name" {
    type = string
}

variable "auto_scaling_group_min_inst" {
    type = string
}

variable "auto_scaling_group_max_inst" {
    type = string
}

variable "availability_zone" {
    type = list(string)
}