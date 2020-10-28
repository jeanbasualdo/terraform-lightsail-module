# Terraform Simple Lightsail Module

Simple way to spin up AWS lightsail instances with custom start-up scripts, network and firewall.

## How to use it

### Variables

| Variable | Description | Default |
|----------|-------------|---------|
| name | Lightsail Instance Identifier. |  |
| region | AWS Region. | `us-east-1` |
| availability_zone | AWS Availability Zone (Lightsail doesn't support all availability zones). | `us-east-1a` |
| blueprint_id | Base image for the instance. Use **`aws lightsail get-blueprints`** to get valid ids. | `ubuntu_18_04` |
| bundle_id | LightSail Instance type. Use **`aws lightsail get-bundles`** to get valid ids. | `micro_2_0` |
| ssh_key | AWS LightSail SSH Key Pair. It creates a new one if not specified. |  |
| user_data | Start-up Script (Optional). |  |
| public_ports | Port Info rules using 'lightsail put-instance-public-ports' See: https://docs.aws.amazon.com/cli/latest/reference/lightsail/put-instance-public-ports.html | `fromPort=22,toPort=22,protocol=tcp` |
| static_ip_id | LightSail IP Identifier, if it's not set a dynamic ip is used or a new static ip is created (see below). |  |
| create_static_ip | If a static ip should be created and attached to the instance. If 'static_ip_id' is set this won't work. | `false` |
| availability_alarm | Enables LightSail Cloud Alarm | `false` |
| tags | Tags for this instance |  |


### Outputs


| Variable | Description |
|----------|-------------|
| arn | ARN of created LightSail Instance. |
| id | Id of created LightSail Instance. | 
| staticip_arn | ARN of the static ip attached to created instance. |
| ip_address | IP Address of created instance.  |


### Example


```hcl

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

module "lightsail" {
  source             = "git::https://github.com/jeanbasualdo/terraform-lightsail-module.git"
  name               = "demo-app"
  region             = "us-east-1"
  availability_zone  = "us-east-1a"
  blueprint_id       = "ubuntu_18_04"
  bundle_id          = "medium_2_0"
  user_data          = file("${path.module}/setup.sh")
  public_ports       = "fromPort=22,toPort=22,protocol=tcp fromPort=80,toPort=80,protocol=tcp"
  create_static_ip   = true
  availability_alarm = false
}

```