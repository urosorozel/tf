resource "openstack_networking_router_v2" "router_1" {
  name                = "my_router"
  admin_state_up      = true
  external_network_id = "${data.openstack_networking_network_v2.openstack_external_network.id}"
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id = "${openstack_networking_router_v2.router_1.id}"
  subnet_id = "${openstack_networking_subnet_v2.management_subnet.id}"
}

# Create a management network
resource "openstack_networking_network_v2" "management_network" {
  name           = "${var.management_network}"
  admin_state_up = "true"
}


# Create a management subnet
resource "openstack_networking_subnet_v2" "management_subnet" {
  name       = "${var.management_subnet}"
  network_id = "${openstack_networking_network_v2.management_network.id}"
  cidr       = "${var.management_subnet_cidr}"
  dns_nameservers = ["1.1.1.1"]
  ip_version = 4
}

# Create a private network
resource "openstack_networking_network_v2" "dhcp_network" {
  name           = "${var.dhcp_network}"
  admin_state_up = "true"
}


# Create a subnet without dhcp
resource "openstack_networking_subnet_v2" "dhcp_subnet" {
  name       = "${var.dhcp_subnet}"
  network_id = "${openstack_networking_network_v2.dhcp_network.id}"
  cidr       = "${var.dhcp_subnet_cidr}"
  ip_version = 4
  enable_dhcp = false
}

resource "openstack_networking_secgroup_v2" "secgroup_1" {
  name        = "SSH"
  description = "SSH security group"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_1.id}"
}

variable "count" {
  default = 2
}

resource "openstack_networking_floatingip_v2" "dhcp_client_floating_ip" {
  pool = "${var.openstack_floating_ip_pool}"
}

resource "openstack_compute_instance_v2" "dhcp_client_instance" {
  name            = "dhcp-client"
#  name = "${format("basic-%02d", count.index+1)}"
#  count = "${var.count}"
  image_id        = "${data.openstack_images_image_v2.openstack_image.id}"
  flavor_id       = "${data.openstack_compute_flavor_v2.openstack_flavor.id}"
  key_pair        = "${var.openstack_keypair}"
  security_groups = ["${openstack_networking_secgroup_v2.secgroup_1.name}"]

  network {
    name = "${openstack_networking_network_v2.management_network.name}"
  }

  network {
    name = "${openstack_networking_network_v2.dhcp_network.name}"
  }
}

resource "openstack_compute_floatingip_associate_v2" "dhcp_client_floating_ip" {
  floating_ip = "${openstack_networking_floatingip_v2.dhcp_client_floating_ip.address}"
  instance_id = "${openstack_compute_instance_v2.dhcp_client_instance.id}"
  fixed_ip    = "${openstack_compute_instance_v2.dhcp_client_instance.network.0.fixed_ip_v4}"
  #wait_until_associated = true
}

resource "openstack_networking_floatingip_v2" "dhcp_server1_floating_ip" {
  pool = "${var.openstack_floating_ip_pool}"
}

resource "openstack_compute_instance_v2" "dhcp_server1_instance" {
  name            = "dhcp-server1"
  image_id        = "${data.openstack_images_image_v2.openstack_image.id}"
  flavor_id       = "${data.openstack_compute_flavor_v2.openstack_flavor.id}"
  key_pair        = "${var.openstack_keypair}"
  security_groups = ["${openstack_networking_secgroup_v2.secgroup_1.name}"]

  network {
    name = "${openstack_networking_network_v2.management_network.name}"
  }

  network {
    name = "${openstack_networking_network_v2.dhcp_network.name}"
  }
}

resource "openstack_compute_floatingip_associate_v2" "dhcp_server1_floating_ip" {
  floating_ip = "${openstack_networking_floatingip_v2.dhcp_server1_floating_ip.address}"
  instance_id = "${openstack_compute_instance_v2.dhcp_server1_instance.id}"
  fixed_ip    = "${openstack_compute_instance_v2.dhcp_server1_instance.network.0.fixed_ip_v4}"
  #wait_until_associated = true
}

resource "openstack_networking_floatingip_v2" "dhcp_server2_floating_ip" {
  pool = "${var.openstack_floating_ip_pool}"
}

resource "openstack_compute_instance_v2" "dhcp_server2_instance" {
  name            = "dhcp-server2"
  image_id        = "${data.openstack_images_image_v2.openstack_image.id}" 
  flavor_id       = "${data.openstack_compute_flavor_v2.openstack_flavor.id}"
  key_pair        = "${var.openstack_keypair}"
  security_groups = ["${openstack_networking_secgroup_v2.secgroup_1.name}"]

  network {
    name = "${openstack_networking_network_v2.management_network.name}"
  }

  network {
    name = "${openstack_networking_network_v2.dhcp_network.name}"
  }
}

resource "openstack_compute_floatingip_associate_v2" "dhcp_server2_floating_ip" {
  floating_ip = "${openstack_networking_floatingip_v2.dhcp_server2_floating_ip.address}"
  instance_id = "${openstack_compute_instance_v2.dhcp_server2_instance.id}"
  fixed_ip    = "${openstack_compute_instance_v2.dhcp_server2_instance.network.0.fixed_ip_v4}"
  #wait_until_associated = true
}

#resource "openstack_blockstorage_volume_v2" "myvol" {
#  name = "myvol"
#  size = 1
#}
#
#resource "openstack_compute_volume_attach_v2" "attached" {
#  instance_id = "${openstack_compute_instance_v2.basic.id}"
#  volume_id = "${openstack_blockstorage_volume_v2.myvol.id}"
#}
