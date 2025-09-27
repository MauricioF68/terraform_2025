resource "docker_container" "app1" {
  name  = "nginx-app1${terraform.workspace}"
  image = "nginx:stable-perl"  

  ports {
    internal = 80
    external = var.nginx_app1_external_port[terraform.workspace]
  }
   networks_advanced {
    name = docker_network.app_network.name
  }
  
}

resource "docker_container" "app2" {
  name  = "nginx-app2${terraform.workspace}"
  image = "nginx:stable-perl"

  ports {
    internal = 80
    external = var.nginx_app2_external_port[terraform.workspace]
  }
  networks_advanced {
    name = docker_network.app_network.name
  }
  networks_advanced {
    name = docker_network.persistence_network.name
  }
}

resource "docker_container" "app3" {
  name  = "nginx-app3${terraform.workspace}"
  image = "nginx:stable-perl"

  ports {
    internal = 80
    external = var.nginx_app3_external_port[terraform.workspace]
  }
  networks_advanced {
    name = docker_network.app_network.name
  }
  networks_advanced {
    name = docker_network.monitor_network.name
  }
}
