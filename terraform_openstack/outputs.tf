output "next-cloud-master" {
  value = openstack_compute_instance_v2.next-cloud-master.name
}

output "next-cloud-master-ip" {
  value = openstack_compute_instance_v2.next-cloud-master.network[0].fixed_ip_v4
}
