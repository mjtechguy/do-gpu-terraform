resource "digitalocean_firewall" "default" {
  name = "${var.droplet_name}-firewall"

  droplet_ids = [digitalocean_droplet.gpu.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "all"
    source_addresses = var.allowed_ips
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "all"
    source_addresses = var.allowed_ips
  }
}