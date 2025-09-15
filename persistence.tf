resource "docker_container" "postgres" {
  name  = "postgres-${terraform.workspace}"
  image = "postgres:13-trixie"
  environment = [
    "POSTGRES_PASSWORD=${var.postgres_password}"
  ]

  ports {
    internal = 5432
    external = var.postgres_external_port[terraform.workspace]
  }
}

resource "docker_container" "redis" {
  name  = "redis-${terraform.workspace}"
  image = "redis:latest"

  ports {
    internal = 6379 
    external = var.redis_external_port[terraform.workspace]
  }
}