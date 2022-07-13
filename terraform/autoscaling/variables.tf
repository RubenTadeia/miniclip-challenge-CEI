## 
# Variables

variable "first_script" {
    type = string
}

variable "ami_name" {
    type = string
}

variable "server_name" {
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