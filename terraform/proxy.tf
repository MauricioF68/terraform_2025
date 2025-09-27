resource "docker_container" "nginx_proxy" {
  name  = "nginx_proxy"
  image = "nginx:stable-perl"

  ports {
    internal = 80
    external = 50010
  }
  networks_advanced {
    name = docker_network.app_network.name
  }

  volumes {
    host_path      = abspath("${path.module}/../host_volumes/nginx_conf")
    container_path = "/etc/nginx/conf.d"
    read_only      = false
  }

 
  volumes {
    host_path      = abspath("${path.module}/../host_volumes/web")
    container_path = "/usr/share/nginx/html"
    read_only      = false
    } 

}
