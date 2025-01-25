# Digital Ocean GPU With Terraform

This project utilizes Terraform to deploy a GPU-optimized Droplet on DigitalOcean, configured with essential packages and tools for performance monitoring and system management. The deployment is automated using a cloud-init script to streamline the setup process.

## Prerequisites

Before you begin, ensure you have the following:

- Terraform: Installed on your local machine.
- DigitalOcean Account: Access to create Droplets and manage resources.
- DigitalOcean API Token: Generate a personal access token from your DigitalOcean account.
- Account approved for GPU usage: Ensure your account is approved for GPU usage on DigitalOcean. Contact support if you need to enable GPU access.

## Cloud-Init Script

The `cloud-init.yaml` script is used to automate the initial configuration of the Droplet. It performs the following actions:

- Updates and upgrades existing packages
- Installs essential packages: htop, tar, git, wget, curl, nano, unzip, and nvtop
- Downloads and installs btop for resource monitoring. (which inlcudes the option to monitor GPU usage)
- Optional: Uncomment lines to install ollama and pull llama3.3 for inferencing

## Firewall Configuration

The `firewall.tf` file configures the DigitalOcean firewall to restrict access to the Droplet. By default, only the IP addresses specified in the `allowed_ips` variable are allowed to access all ports on the Droplet.

## Variables

The following table outlines the variables in the `terraform.tfvars` file used in this project:

| Variable             | Description                                           | Type   | Default                  | Required |
|----------------------|-------------------------------------------------------|--------|--------------------------|----------|
| `do_token`           | DigitalOcean API token                                | string |                          | yes      |
| `project_name`       | Name of the project where Droplet will be created     | string | `gpu-terraform`          | yes      |
| `droplet_name`       | Name of the Droplet                                   | string | `gpu-droplet`            | no       |
| `region`             | Region to deploy the Droplet                          | string | `nyc2`                   | no       |
| `size`               | Droplet size slug                                     | string | `gpu-h100x1-80gb`        | no       |
| `image`              | Droplet image slug                                    | string | `gpu-h100x1-base`        | no       |
| `ssh_key_name`       | Name for the SSH key                                  | string | `my-custom-key`          | no       |
| `allowed_ips`        | List of IPs allowed to access all ports               | list   | `["192.0.2.1/32"]`       | no       |
| `enable_destroy_cron`| Enable or disable the creation of the delete cronjob  | bool   | `false`                  | no       |
| `destroy_after_minutes`| Time in minutes before the Droplet is destroyed     | number | `60`                     | no       |

Note: Replace the default values with your specific configurations as needed. Also, uncomment the lines for `enabled_destroy_cron` and `destroy_after_minutes` if you wish to enable the automatic deletion of the Droplet. This only works on Linux systems.

## Usage

1. Clone the repository and navigate to the project directory
2. Copy the `terraform.tfvars.example` file to `terraform.tfvars` and update the variables with your configurations.
3. Initialize Terraform: Run `terraform init` to initialize the project and download necessary providers.
4. Plan the Deployment: Execute `terraform plan` to review the resources that will be created.
5. Apply the Configuration: Run `terraform apply` to create the Droplet and associated resources.
6. Access the Droplet: Use the provided SSH command output to connect to your Droplet.

## Outputs

After applying the configuration, Terraform will provide the following outputs:

- id_rsa: The private SSH key for connecting to the Droplet.
- id_rsa.pub: The public SSH key for connecting to the Droplet.
- ssh_command: The SSH command to connect to the Droplet.

## Security Considerations

- Ensure that your do_token is kept secure and not exposed in version control systems.
- Only include trusted IP addresses in the allowed_ips variable to maintain security.

## Cleanup

To destroy the resources created by this project, run:

`terraform destroy`

This command will remove all resources defined in your Terraform configuration.

Or, if you enabled the destroy cronjob, the Droplet will be automatically deleted at the specified time. (Linux support only)

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.