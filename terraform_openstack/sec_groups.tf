resource "openstack_compute_secgroup_v2" "all-open-local" {
  name        = "all-open-local"
  description = "Allow ALL (TCP/UDP/ICMP) traffic from local network. Managed by terraform."

  rule {
    from_port   = 1
    to_port     = 65535
    ip_protocol = "tcp"
    cidr        = "192.168.0.0/24"
  }

  rule {
    from_port   = 1
    to_port     = 65535
    ip_protocol = "udp"
    cidr        = "192.168.0.0/24"
  }

  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "192.168.0.0/24"
  }
}

resource "openstack_compute_secgroup_v2" "ssh-public" {
  name        = "ssh-public"
  description = "Allow SSH (TCP/22) traffic from anywhere (0.0.0.0/0). Managed by terraform."

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "grafana-public" {
  name        = "grafana-public"
  description = "Allow access to port (TCP/3000) traffic from anywhere (0.0.0.0/0). Managed by terraform."

  rule {
    from_port   = 3000
    to_port     = 3000
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "https-public" {
  name        = "http-public"
  description = "Allow SSH (TCP/80) traffic from anywhere (0.0.0.0/0). Managed by terraform."

  rule {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}

