variable "upload-dns" {
  default = "upload.galaxyproject.eu"
}

data "openstack_images_image_v2" "upload-image" {
  name = "generic-rockylinux8-v60-j168-5333625af7b2-main"
}

resource "openstack_compute_instance_v2" "upload" {
  name            = var.upload-dns
  image_id        = data.openstack_images_image_v2.upload-image.id
  flavor_name     = "m1.medium"
  key_pair        = "cloud2"
  security_groups = ["default", "public-ssh", "public-web2", "ufr-ingress"]

  network {
    name = "bioinf"
  }

  user_data = <<-EOF
    #cloud-config
    package_update: true
    package_upgrade: true
  EOF
}
