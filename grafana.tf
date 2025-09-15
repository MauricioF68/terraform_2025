resource "docker_container" "grafana" {
  name  = "grafana-${terraform.workspace}"
  image = "grafana/grafana:main-ubuntu"

  ports {
    internal = 3000 
    external = var.postgres_external_port[terraform.workspace]
  }
}