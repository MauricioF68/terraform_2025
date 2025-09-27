variable "nginx_app1_external_port" {
  description = "Coloca el puerto de NGINX_APP1"
}
variable "nginx_app2_external_port" {
  description = "Coloca el puerto de NGINX_APP2"
}
variable "nginx_app3_external_port" {
  description = "Coloca el puerto de NGINX_APP3"
}

variable "postgres_password"{
    description = "Contraseña postgre"
}

variable "postgres_external_port" {
  description = "Coloca el puerto de POSTGRE"
}

variable "redis_external_port" {
  description = "Coloca el puerto de REDIS"
}

variable "grafana_external_port" {
  description = "Coloca el puerto de GRAFANA"
}