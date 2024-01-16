provider "alicloud" {
  access_key = var.aliyun_access_key
  secret_key = var.aliyun_secret_key
  region     = var.region
}

resource "alicloud_vpc" "vpc" {
  vpc_name = "terraform_generated_vpc"
}

resource "alicloud_vswitch" "vswitch" {
  cidr_block   = "172.16.0.0/24"
  zone_id      = data.alicloud_zones.zones.zones.0.id
  vpc_id       = alicloud_vpc.vpc.id
  vswitch_name = "terraform_generated_vswitch"
}
