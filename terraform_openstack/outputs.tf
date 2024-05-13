output "next-cloud" {
  value = openstack_compute_instance_v2.next-cloud.name
}

output "next-cloud-ip" {
  value = openstack_compute_instance_v2.next-cloud.network[0].fixed_ip_v4
}

output "maria-db-ip" {
  value = openstack_compute_instance_v2.maria-db.network[0].fixed_ip_v4
}

output "redis-ip" {
  value = openstack_compute_instance_v2.redis.network[0].fixed_ip_v4
}