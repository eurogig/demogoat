data google_compute_zones "zones" {}

resource google_compute_instance "server" {
  machine_type = "n1-standard-1"
  name         = "terragoat-${var.environment}-machine"
  zone         = data.google_compute_zones.zones.names[0]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
    auto_delete = true
  }
  network_interface {
    subnetwork = google_compute_subnetwork.public-subnetwork.name
    access_config {}
  }
  can_ip_forward = true

  metadata = {
    block-project-ssh-keys = false
    enable-oslogin         = false
    serial-port-enable     = true
  }
  labels = {
    git_commit           = "bea73fff3964500456bae8521afa84815c41f921"
    git_file             = "terraform__gcp__instances_tf"
    git_last_modified_at = "2021-06-17-14-09-33"
    git_last_modified_by = "eurogig"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "seceng"
    yor_trace            = "08834a4d-a9e6-4023-b299-0e7a7751517f"
  }
}

resource google_compute_disk "unencrypted_disk" {
  name = "terragoat-${var.environment}-disk"
  labels = {
    git_commit           = "bea73fff3964500456bae8521afa84815c41f921"
    git_file             = "terraform__gcp__instances_tf"
    git_last_modified_at = "2021-06-17-14-09-33"
    git_last_modified_by = "eurogig"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "seceng"
    yor_trace            = "39ec72c9-06a3-4e84-8423-0c534ded2ebb"
  }
}