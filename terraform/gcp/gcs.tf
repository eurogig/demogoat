resource "google_storage_bucket" "terragoat_website" {
  name          = "terragot-${var.environment}"
  force_destroy = true
  labels = {
    git_commit           = "bea73fff3964500456bae8521afa84815c41f921"
    git_file             = "terraform__gcp__gcs_tf"
    git_last_modified_at = "2021-06-17-14-09-33"
    git_last_modified_by = "eurogig"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
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