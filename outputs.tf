output "ssh_command" {
  description = "SSH command to connect to the Droplet"
  value       = "ssh -i id_rsa root@${digitalocean_droplet.gpu.ipv4_address}"
}

resource "local_file" "private_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = "${path.module}/id_rsa"
}

resource "local_file" "public_key" {
  content  = tls_private_key.ssh_key.public_key_openssh
  filename = "${path.module}/id_rsa.pub"
}