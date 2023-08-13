variable "AWS_REGION" {
  description = "AWS region for the deployment"
  type        = string
  default     = "ap-southeast-2"
}

variable "project" {
  type = string
}

variable "environment" {
  type    = string
}

variable "endpoint" {
  type    = string
}

variable "period" {
  type    = number
}

variable "threshold" {
  type    = number
}