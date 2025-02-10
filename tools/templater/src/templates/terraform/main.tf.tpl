resource "stackit_objectstorage_bucket" "bucket" {
  project_id = var.project_id
  name       = var.bucket_name
}

resource "stackit_objectstorage_credential" "bucket_credential" {
  project_id           = var.project_id
  credentials_group_id = stackit_objectstorage_credentials_group.terraform_state.credentials_group_id
}

resource "stackit_objectstorage_credentials_group" "terraform_state" {
  project_id = var.project_id
  name       = var.tf_state_bucket_key
}
