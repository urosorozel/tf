variable "openstack_user_name" {
    description = "The username for the Tenant."
    default  = "admin"
}

variable "openstack_tenant_name" {
    description = "The name of the Tenant."
    default  = "admin"
}

variable "openstack_password" {
    description = "The password for the Tenant."
    default  = "346f8720c8b15402dfc1a281a435571ce51bf4b6ebb7f27c659c1"
}

variable "openstack_auth_url" {
    description = "The endpoint url to connect to OpenStack."
    default  = "http://172.29.236.100:5000/v3"
}

variable "openstack_keypair" {
    description = "The keypair to be used."
    default  = "uros"
}

variable "openstack_image" {
    description = "The instance image to be used."
    default  = "ubuntu"
}

variable "openstack_flavor" {
    description = "The instance flavor to be used."
    default  = "small"
}
variable "openstack_floating_ip_pool" {
    description = "The floating ip pool to be used."
    default  = "public"
}

variable "openstack_region" {
    description = "The region to be used."
    default  = "RegionOne"
}

variable "openstack_external_network" {
    description = "Opesntack external network."
    default  = "public"
}

variable "management_network" {
    description = "The management subnet to be created."
    default  = "management_network"
}

variable "management_subnet" {
    description = "The management subnet to be created."
    default  = "management_subnet"
}

variable "management_subnet_cidr" {
    description = "The management subnet cidr to be created."
    default  = "192.168.5.10/24"
}

variable "dhcp_network" {
    description = "The dhcp subnet to be created."
    default  = "dhcp_network"
}

variable "dhcp_subnet" {
    description = "The dhcp subnet to be created."
    default  = "management_subnet"
}

variable "dhcp_subnet_cidr" {
    description = "The dhcp subnet cidr to be created."
    default  = "192.168.10.10/24"
}

variable "dhcp_client_floating_ip" {
    description = "The dhcp client instance floating ip"
    default  = "dhcp_instance_floating_ip"
}

variable "dhcp_server1_floating_ip" {
    description = "The dhcp server1 instance floating ip"
    default  = "dhcp_server1_floating_ip"
}

variable "dhcp_server2_floating_ip" {
    description = "The dhcp server2 instance floating ip"
    default  = "dhcp_server2_floating_ip"
}

variable "external_dns_server" {
   description = "Extenal DNS servers to use on management subnet"
   default = ["1.1.1.1"]
}
