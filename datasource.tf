data "openstack_compute_flavor_v2" "openstack_flavor" {
  vcpus = 2
  ram   = 2048
}

data "openstack_images_image_v2" "openstack_image" {
  name = "xenial"
  most_recent = true
}

data "openstack_networking_network_v2" "openstack_external_network" {
  name = "${var.openstack_external_network}"
}
