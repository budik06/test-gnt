variable "environment" {
  type        = string
  description = "The environment (e.g., dev, staging, prod)"
}

variable "project" {
  type        = string
  description = "Project name"
}

variable "region" {
  description = "Default zone"
}

variable "folder_id" {
  type = string
}

variable "network_id" {
  type = string
}

variable "vm_user" {
  type = string
}

variable "vm_userp" {
  type = string
}
