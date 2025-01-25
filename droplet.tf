data "digitalocean_project" "project" {
  name = var.project_name
}

resource "digitalocean_ssh_key" "default" {
  name       = var.ssh_key_name
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "digitalocean_droplet" "gpu" {
  name = "${var.droplet_name}-${var.size == "gpu-h100x1-80gb" ? "H100x1" : "H100x8"}"
  region = var.region
  size   = var.size
  image  = var.image
  ssh_keys = [digitalocean_ssh_key.default.id]
  user_data = file("${path.module}/cloud-init.yaml")

}

resource "digitalocean_project_resources" "dev" {
  project = data.digitalocean_project.project.id
  resources = [
    digitalocean_droplet.gpu.urn
  ]
}

# resource "null_resource" "schedule_destruction" {
#   count = var.enable_destroy_cron ? 1 : 0

#   provisioner "local-exec" {
#     command = "${path.module}/schedule_destruction.sh ${var.destroy_after_minutes}"
#   }

#   depends_on = [digitalocean_droplet.gpu]
# }