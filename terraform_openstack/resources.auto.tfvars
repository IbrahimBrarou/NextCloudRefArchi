next_cloud_node = ({
  flavor_name  = "m2.medium"
  floating_ip  = "193.225.250.156"
  image_id     = "d6bf6eac-2e0b-49a4-a280-026bf661bf30"
  key_pair     = "id_rsa"
  name         = "nextcloud"
  network_name = "default"
  volume_size  = 20
})

db_node = ({
  flavor_name  = "m2.medium"
  image_id     = "d6bf6eac-2e0b-49a4-a280-026bf661bf30"
  key_pair     = "id_rsa"
  name         = "mariadb"
  network_name = "default"
  volume_size  = 20
})

redis_node = ({
  flavor_name  = "m2.medium"
  image_id     = "d6bf6eac-2e0b-49a4-a280-026bf661bf30"
  key_pair     = "id_rsa"
  name         = "redis"
  network_name = "default"
  volume_size  = 20
})

grafana_node = ({
  flavor_name  = "m2.medium"
  image_id     = "d6bf6eac-2e0b-49a4-a280-026bf661bf30"
  key_pair     = "id_rsa"
  name         = "grafana"
  network_name = "default"
  volume_size  = 20
})