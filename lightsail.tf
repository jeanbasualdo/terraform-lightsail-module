terraform {
  required_version = "~> 0.12.0"

  required_providers {
    aws  = "~> 2.0"
    null = "~> 2.0"
  }
}

resource "aws_lightsail_instance" "main" {
  name              = var.name
  availability_zone = var.availability_zone
  blueprint_id      = var.blueprint_id
  bundle_id         = var.bundle_id
  key_pair_name     = var.ssh_key == "" ? "${var.name}-key" : var.ssh_key
  tags              = var.tags
  depends_on        = [aws_lightsail_key_pair.alt]
  user_data         = var.user_data

  provisioner "local-exec" {
    command = "aws lightsail put-instance-public-ports --instance-name=${var.name} --port-infos ${var.public_ports} --region ${var.region}"
  }
}

resource "aws_lightsail_static_ip_attachment" "main" {
  count          = var.static_ip_id != "" ? 1 : 0
  static_ip_name = var.static_ip_id
  instance_name  = aws_lightsail_instance.main.id
}

resource "aws_lightsail_static_ip" "alt" {
  count = (var.create_static_ip && var.static_ip_id == "") ? 1 : 0
  name  = "${var.name}-ip"
}

resource "aws_lightsail_static_ip_attachment" "alt" {
  count          = (var.create_static_ip && var.static_ip_id == "") ? 1 : 0
  static_ip_name = "${var.name}-ip"
  instance_name  = aws_lightsail_instance.main.id
}

resource "aws_lightsail_key_pair" "alt" {
  count = var.ssh_key == "" ? 1 : 0
  name  = "${var.name}-key"
}

resource "null_resource" "email_alarm" {
  count = var.availability_alarm ? 1 : 0
  provisioner "local-exec" {
    command = <<EOT
      aws lightsail put-alarm --contact-protocols Email --alarm-name ${var.name}-status-checks --metric-name StatusCheckFailed --monitored-resource-name ${var.name} --comparison-operator GreaterThanThreshold --threshold 0 --evaluation-periods 1 --region ${var.region}
    EOT 
  }
  depends_on = [aws_lightsail_instance.main]
}
