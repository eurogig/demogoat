resource "azurerm_resource_group" "example" {
  name     = "terragoat-${var.environment}"
  location = var.location
  tags = {
    git_commit           = "2384d4d87f0d949f4e7c31718827a92ad9fdc27d"
    git_file             = "terraform/azure/resource_group.tf"
    git_last_modified_at = "2021-06-17 14:08:57"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "metahertz"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "seceng"
    yor_trace            = "c1ff7bd1-062a-4002-8391-f77501ed336e"
  }
}