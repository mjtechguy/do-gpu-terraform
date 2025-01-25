variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
}

variable "project_name" {
  description = "Name of the project where the Droplet will be created"
  type        = string
  default     = "mjproject"
}

variable "droplet_name" {
  description = "Name of the Droplet"
  type        = string
  default     = "gpu-droplet"
}

variable "region" {
  description = "Region to deploy the Droplet in"
  type        = string
  default     = "nyc2"
}

variable "size" {
  description = "Droplet size slug (e.g., 'gpu-h100x1-80gb' for a single NVIDIA H100 GPU 0r 'gpu-h100x8-640gb' for 8 NVIDIA H100 GPUs)"
  type        = string
  default     = "gpu-h100x1-80gb"
}

variable "image" {
  description = "Droplet image slug"
  type        = string
  default     = "gpu-h100x1-base"
}

variable "ssh_key_name" {
  description = "Name for the SSH key"
  type        = string
  default     = "terraform-generated"
}

variable "allowed_ips" {
  description = "List of IP addresses allowed to access all ports"
  type        = list(string)
  default     = ["192.0.2.1/32", "198.51.100.1/32"]  # Replace with your actual IPs
}

variable "enable_destroy_cron" {
  description = "Flag to determine whether to create the cron job for automatic Droplet destruction"
  type        = bool
  default     = false
}

variable "destroy_after_minutes" {
  description = "Time in minutes after which the Droplet will be destroyed"
  type        = number
  default     = 60
}