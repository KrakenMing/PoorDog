variable "region" {
  description = "Value of ECS zone ID"
  type        = string
  default     = "cn-hongkong"
  # default     = "cn-qingdao"
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

# variable "pubkey" {
#   description = "ECS public key"
#   type        = string
#   sensitive   = true
# }
