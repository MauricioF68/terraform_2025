resource "docker_network" "app_network" {
  name = "app_net"
}

resource "docker_network" "persistence_network" {
  name = "persistence_net"
}

resource "docker_network" "monitor_network" {
  name = "monitor_net"
}
