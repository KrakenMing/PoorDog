provider "alicloud" {
  access_key = var.aliyun_access_key
  secret_key = var.aliyun_secret_key
  region     = var.region
}


# resource "alicloud_ecs_key_pair" "key" {
#   key_file = "test"
# }

data "alicloud_images" "images" {
  name_regex = "^ubuntu_[0-9]+_[0-9]+_uefi_x64.*"
}

output "output" {
  value = data.alicloud_images.images
}   


# data "alicloud_zones" "zones" {
#   available_resource_creation = "VSwitch"
# }

# output "zones_output" {
#   value = data.alicloud_zones.zones
# }