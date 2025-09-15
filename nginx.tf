resource "docker_container" "app1" {
  name  = "nginx-app1${terraform.workspace}"
  image = "nginx:stable-perl"

  ports {
    internal = 80
    external = var.nginx_external_port[terraform.workspace]
  }
}

resource "docker_container" "app2" {
  name  = "nginx-app2${terraform.workspace}"
  image = "nginx:stable-perl"

  ports {
    internal = 80
    external = var.nginx_external_port[terraform.workspace]
  }
}

resource "docker_container" "app3" {
  name  = "nginx-app3${terraform.workspace}"
  image = "nginx:stable-perl"

  ports {
    internal = 80
    external = var.nginx_external_port[terraform.workspace]
  }
}
