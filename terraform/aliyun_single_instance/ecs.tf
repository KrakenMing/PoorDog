variable "name" {
  default = "terraform-ecs"
}

data "alicloud_images" "images" {
  owners     = "system"
  name_regex = "^ubuntu_[0-9]+_[0-9]+_uefi_x64.*"
}

resource "alicloud_instance" "instance" {
  dry_run         = var.ecs_dry_run
  security_groups = alicloud_security_group.securityGroup.*.id

  instance_type              = "ecs.t5-c1m1.large"
  instance_name              = var.name
  system_disk_category       = "cloud_efficiency"
  system_disk_size           = 20
  internet_charge_type       = "PayByTraffic"
  internet_max_bandwidth_out = 10
  host_name                  = "${var.name}-1"
  password                   = var.ecs_password
  instance_charge_type       = "PostPaid"

  vswitch_id = alicloud_vswitch.vswitch.id
  image_id   = data.alicloud_images.images.images.0.id

  spot_strategy    = "SpotWithPriceLimit"
  spot_price_limit = 0.15
  spot_duration    = 0
}

output "ecs_public_ip" {
  description = "The public ip of the ECS that Terraform created"
  value       = alicloud_instance.instance.public_ip
}