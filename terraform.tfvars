nginx_app1_external_port = {
  dev  = 8081
  qa   = 9081
  prod = 80
}

nginx_app2_external_port = {
  dev  = 8082
  qa   = 9082
  prod = 81
}

nginx_app3_external_port = {
  dev  = 8083
  qa   = 9083
  prod = 82
}
postgres_external_port = {
  dev  = 5432
  qa   = 5433
  prod = 5432
}

postgres_password = "contrasena123456"

redis_external_port = {
  dev  = 6379
  qa   = 6380
  prod = 6379
}

grafana_external_port = {
  dev  = 3000
  qa   = 3001
  prod = 3000
}