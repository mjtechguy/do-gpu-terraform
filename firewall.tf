resource "digitalocean_firewall" "default" {
  name = "${var.droplet_name}-firewall"

  droplet_ids = [digitalocean_droplet.gpu.id]

  # Inbound rules (unchanged)
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

  # Outbound rules for full access
  outbound_rule {
    protocol         = "tcp"
    port_range       = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol         = "udp"
    port_range       = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Optional: Allow ICMP for pings and diagnostics
  outbound_rule {
    protocol         = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}