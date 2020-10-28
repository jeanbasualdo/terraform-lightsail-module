output "arn" {
  value = aws_lightsail_instance.main.arn
}

output "id" {
  value = aws_lightsail_instance.main.id
}

output "staticip_arn" {
  value = aws_lightsail_static_ip.alt.*.arn
}

output "ip_address" {
  value = aws_lightsail_static_ip.alt.*.ip_address
}

output "key_id" {
  value = aws_lightsail_key_pair.alt.*.id
}

output "key_arn" {
  value = aws_lightsail_key_pair.alt.*.arn
}

output "fingerprint" {
  value = aws_lightsail_key_pair.alt.*.fingerprint
}

output "public_key" {
  value = aws_lightsail_key_pair.alt.*.public_key
}

output "private_key" {
  value = aws_lightsail_key_pair.alt.*.private_key
}

output "encrypted_private_key" {
  value = aws_lightsail_key_pair.alt.*.encrypted_private_key
}

output "encrypted_fingerprint" {
  value = aws_lightsail_key_pair.alt.*.encrypted_fingerprint
} 