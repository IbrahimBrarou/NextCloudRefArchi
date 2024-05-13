# Telling terraform which provider to download from the Terraform Registry
terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    version = "1.53.0" }
  }
}

# resource specific configuration
resource "openstack_compute_instance_v2" "next-cloud" {
  name        = var.next_cloud_node.name
  flavor_name = var.next_cloud_node.flavor_name
  key_pair    = var.next_cloud_node.key_pair
  security_groups = [
    "${openstack_compute_secgroup_v2.all-open-local.id}",
    "${openstack_compute_secgroup_v2.ssh-public.id}",
    "${openstack_compute_secgroup_v2.https-public.id}",

  ]

  block_device {
    uuid                  = var.next_cloud_node.image_id
    source_type           = "image"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
    volume_size           = var.next_cloud_node.volume_size
  }

  network {
    name = var.next_cloud_node.network_name
  }
}

resource "openstack_compute_instance_v2" "maria-db" {
  name        = var.db_node.name
  flavor_name = var.db_node.flavor_name
  key_pair    = var.db_node.key_pair
  security_groups = [
    "${openstack_compute_secgroup_v2.all-open-local.id}",
    "${openstack_compute_secgroup_v2.ssh-public.id}",
  ]

  block_device {
    uuid                  = var.db_node.image_id
    source_type           = "image"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
    volume_size           = var.db_node.volume_size
  }

  network {
    name = var.db_node.network_name
  }
}

resource "openstack_compute_instance_v2" "redis" {
  name        = var.redis_node.name
  flavor_name = var.redis_node.flavor_name
  key_pair    = var.redis_node.key_pair
  security_groups = [
    "${openstack_compute_secgroup_v2.all-open-local.id}",
    "${openstack_compute_secgroup_v2.ssh-public.id}",
  ]

  block_device {
    uuid                  = var.redis_node.image_id
    source_type           = "image"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
    volume_size           = var.redis_node.volume_size
  }

  network {
    name = var.redis_node.network_name
  }
}

resource "openstack_compute_instance_v2" "grafana" {
  count       = var.grafana_node.enabled ? 1 : 0
  name        = var.grafana_node.name
  flavor_name = var.grafana_node.flavor_name
  key_pair    = var.grafana_node.key_pair
  security_groups = [
    "${openstack_compute_secgroup_v2.all-open-local.id}",
    "${openstack_compute_secgroup_v2.ssh-public.id}",
    "${openstack_compute_secgroup_v2.grafana-public.id}",
  ]

  block_device {
    uuid                  = var.grafana_node.image_id
    source_type           = "image"
    destination_type      = "volume"
    boot_index            = 0
    delete_on_termination = true
    volume_size           = var.grafana_node.volume_size
  }

  network {
    name = var.grafana_node.network_name
  }
}

# Associate floating IP to the Nextcloud node.
resource "openstack_compute_floatingip_associate_v2" "fip_nextcloud" {
  count       = var.next_cloud_node.floating_ip == "" ? 0 : 1
  floating_ip = var.next_cloud_node.floating_ip
  instance_id = openstack_compute_instance_v2.next-cloud.id
}

# Associate floating IP to the Grafana node.
resource "openstack_compute_floatingip_associate_v2" "fip_grafana" {
  count       = (var.grafana_node.enabled && var.grafana_node.floating_ip != "") ? 1 : 0
  floating_ip = var.grafana_node.floating_ip
  instance_id = var.grafana_node.enabled ? openstack_compute_instance_v2.grafana[0].id : ""
}

resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tftpl", {
    floating_ip = var.next_cloud_node.floating_ip == "" ? 0 : 1
    proxy_ip    = var.next_cloud_node.floating_ip == "" ? "${openstack_compute_instance_v2.next-cloud.network[0].fixed_ip_v4}" : "${var.next_cloud_node.floating_ip}"
    next_cloud_ip   = openstack_compute_instance_v2.next-cloud.network[0].fixed_ip_v4
    maria_db_ip   = openstack_compute_instance_v2.maria-db.network[0].fixed_ip_v4
    redis_ip = openstack_compute_instance_v2.redis.network[0].fixed_ip_v4
    enable_grafana = var.grafana_node.enabled
    grafana_ip     = var.grafana_node.enabled ? join("", openstack_compute_instance_v2.grafana[*].network[0].fixed_ip_v4) : ""
    }
  )
  filename = "../ansible/hosts.yml"
}
