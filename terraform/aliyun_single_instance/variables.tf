variable "region" {
  description = "Value of ECS zone ID"
  type        = string
  default     = "cn-hongkong"
}

variable "aliyun_access_key" {
  description = "Aliyun access key"
  type        = string
  sensitive   = true
}

variable "aliyun_secret_key" {
  description = "Aliyun secret"
  type        = string
  sensitive   = true
}

variable "ecs_password" {
  description = "ECS default password"
  type        = string
  sensitive   = true
  default     = "Merlin123456"
}

variable "ecs_dry_run" {
  description = "Are the ecs operations dry runs"
  type        = bool
  default     = true
}