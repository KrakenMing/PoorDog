provider "alicloud" {
  access_key = var.aliyun_access_key
  secret_key = var.aliyun_secret_key
  region     = var.region
}

resource "alicloud_vpc" "default" {
  vpc_name = "terraform_generated_vpc"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vswitch" "default" {
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vpc_id       = alicloud_vpc.default.id
  vswitch_name = "terraform_generated_vswitch"
}

