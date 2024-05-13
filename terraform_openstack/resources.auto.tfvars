next_cloud_node = ({
  flavor_name  = "SET_YOUR_FLAVOR_NAME"
  floating_ip  = "SET_YOUR_FLOATING_IP"
  image_id     = "SET_YOUR_IMAGE_ID"
  key_pair     = "SET_YOUR_KEY_PAIR_NAME"
  name         = "nextcloud"
  network_name = "default"
  volume_size  = 20
})

db_node = ({
  flavor_name  = "SET_YOUR_FLAVOR_NAME"
  image_id     = "SET_YOUR_IMAGE_ID"
  key_pair     = "SET_YOUR_KEY_PAIR_NAME"
  name         = "mariadb"
  network_name = "default"
  volume_size  = 20
})

redis_node = ({
  flavor_name  = "SET_YOUR_FLAVOR_NAME"
  image_id     = "SET_YOUR_IMAGE_ID"
  key_pair     = "SET_YOUR_KEY_PAIR_NAME"
  name         = "redis"
  network_name = "default"
  volume_size  = 20
})

grafana_node = ({
  enabled      = false
  flavor_name  = "SET_YOUR_FLAVOR_NAME"
  image_id     = "SET_YOUR_IMAGE_ID"
  floating_ip  = "SET_YOUR_FLOATING_IP"
  key_pair     = "SET_YOUR_KEY_PAIR_NAME"
  name         = "grafana"
  network_name = "default"
  volume_size  = 20
})
