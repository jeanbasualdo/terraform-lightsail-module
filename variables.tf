variable "name" {
  type        = string
  description = "Lightsail Instance Identifier"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS Region"
}

variable "availability_zone" {
  type        = string
  default     = "us-east-1a"
  description = "AWS Availability Zone (Lightsail doesn't support all availability zones)"
}

variable "blueprint_id" {
  type        = string
  default     = "ubuntu_18_04"
  description = "Base image for the instance"
}

variable "bundle_id" {
  type        = string
  default     = "micro_2_0"
  description = "LightSail Instance type"
}

variable "ssh_key" {
  type        = string
  default     = ""
  description = "AWS LightSail SSH Key"
}

variable "user_data" {
  type        = string
  default     = ""
  description = "Start-up Script"
}

variable "public_ports" {
  type        = string
  default     = "fromPort=22,toPort=22,protocol=tcp"
  description = "Port Info rules using 'lightsail put-instance-public-ports' See: https://docs.aws.amazon.com/cli/latest/reference/lightsail/put-instance-public-ports.html"
}

variable "static_ip_id" {
  type        = string
  default     = ""
  description = "LightSail IP Identifier, if it's not set a dynamic ip is used."
}

variable "create_static_ip" {
  type        = bool
  default     = false
  description = "If a static ip should be created and attached to the instance. If 'static_ip_id' is set this won't do nothing."
}

variable "availability_alarm" {
  type        = bool
  default     = true
  description = "Enables LightSail Cloud Alarm"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the instance"
}
