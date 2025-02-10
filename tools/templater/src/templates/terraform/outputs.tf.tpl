output "backend_config" {
  value = <<EOT
    backend "s3" {
      bucket                      = "${stackit_objectstorage_bucket.bucket.name}"
      key                         = "${var.tf_state_bucket_key}"
      endpoints                   = {
        s3 = "https://object.storage.eu01.onstackit.cloud"
      }
      region                      = "eu01"
      skip_credentials_validation = true
      skip_region_validation      = true
      skip_s3_checksum            = true
      skip_requesting_account_id  = true
    }
  EOT
}

output "secret_access_key" {
  value     = stackit_objectstorage_credential.bucket_credential.secret_access_key
  sensitive = true
}

output "access_key" {
  value = stackit_objectstorage_credential.bucket_credential.access_key
}
