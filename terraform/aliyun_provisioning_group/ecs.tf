variable "name" {
  default = "terraform-ecs"
}

data "alicloud_images" "images" {
  owners     = "system"
  name_regex = "^ubuntu_[0-9]+_[0-9]+_uefi_x64.*"
}

resource "alicloud_ecs_key_pair" "key" {
  key_file = "aliyun_private_key"
}

resource "alicloud_ecs_launch_template" "template" {
  zone_id                    = data.alicloud_zones.zones.zones.0.id
  launch_template_name       = "terraform_launch_template"
  security_group_id          = alicloud_security_group.securityGroup.id
  instance_type              = "ecs.t5-c1m1.large"
  instance_name              = var.name
  internet_charge_type       = "PayByTraffic"
  internet_max_bandwidth_out = 10
  host_name                  = "${var.name}-1"
  instance_charge_type       = "PostPaid"
  key_pair_name              = alicloud_ecs_key_pair.key.id

  image_id = data.alicloud_images.images.images.0.id
  system_disk {
    category = "cloud_efficiency"
    size     = 20
  }

  spot_strategy    = "SpotWithPriceLimit"
  spot_price_limit = 0.15
  spot_duration    = 0
}

resource "alicloud_auto_provisioning_group" "provisioning_group" {
  launch_template_id            = alicloud_ecs_launch_template.template.id
  auto_provisioning_group_name  = "terraform_provisioning_group"
  total_target_capacity         = 6
  spot_target_capacity          = 6
  pay_as_you_go_target_capacity = 0
  default_target_capacity_type  = "Spot"
  launch_template_config {
    instance_type     = "ecs.t5-c1m1.large"
    max_price         = 0.15
    vswitch_id        = alicloud_vswitch.vswitch.id
    weighted_capacity = 2
  }
}


output "group_id" {
  description = "The provisioning group ID"
  value       = alicloud_auto_provisioning_group.provisioning_group.id
}