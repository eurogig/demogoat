resource "google_storage_bucket" "terragoat_website" {
  name          = "terragot-${var.environment}"
  force_destroy = true
  labels = {
    git_commit           = "ff3ee8387837a499665630ebb0371be39ce35fb6"
    git_file             = "terraform__gcp__gcs_tf"
    git_last_modified_at = "2020-07-08-12-02-14"
    git_last_modified_by = "nimrodkor"
    git_modifiers        = "nimrodkor"
    git_org              = "eurogig"
    git_repo             = "terragoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "55ae338a-bad6-4f83-b655-1e9930181063"
  }
}

resource "google_storage_bucket_iam_binding" "allow_public_read" {
  bucket  = google_storage_bucket.terragoat_website.id
  members = ["allUsers"]
  role    = "roles/storage.objectViewer"
}