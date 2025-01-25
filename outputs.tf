output "ssh_command" {
  description = "SSH command to connect to the Droplet"
  value       = "ssh -i id_rsa root@${digitalocean_droplet.gpu.ipv4_address}"
}

output "ollama_endpoint" {
  description = "The endpoint to connect to Ollama (if enabled)"
  value       = "http://${digitalocean_droplet.gpu.ipv4_address}:11434"
}