resource "azurerm_key_vault" "example" {
  name                = "terragoat-key-${var.environment}${random_integer.rnd_int.result}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "premium"
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "create",
      "get",
    ]
    secret_permissions = [
      "set",
    ]
  }
  tags = {
    environment          = var.environment
    terragoat            = true
    git_commit           = "81738b80d571fa3034633690d13ffb460e1e7dea"
    git_file             = "terraform/azure/key_vault.tf"
    git_last_modified_at = "2020-06-19 21:14:50"
    git_last_modified_by = "Adin.Ermie@outlook.com"
    git_modifiers        = "Adin.Ermie/nimrodkor"
    git_org              = "eurogig"
    git_repo             = "terragoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "interfaces"
    yor_trace            = "9ca6ab41-57d1-4141-8606-2777eea8a41a"
  }
}

resource "azurerm_key_vault_key" "generated" {
  name         = "terragoat-generated-certificate-${var.environment}"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
  tags = {
    git_commit           = "898d5beaec7ffdef6df0d7abecff407362e2a74e"
    git_file             = "terraform/azure/key_vault.tf"
    git_last_modified_at = "2020-06-17 12:59:55"
    git_last_modified_by = "nimrodkor@gmail.com"
    git_modifiers        = "nimrodkor"
    git_org              = "eurogig"
    git_repo             = "terragoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "f4b0970c-3c48-4d44-ae55-0d0b2dfb1a73"
  }
}

resource "azurerm_key_vault_secret" "secret" {
  key_vault_id = azurerm_key_vault.example.id
  name         = "terragoat-secret-${var.environment}"
  value        = random_string.password.result
  tags = {
    git_commit           = "f8ff847bb69370bbe03b3d2b70db586ff6c867fc"
    git_file             = "terraform/azure/key_vault.tf"
    git_last_modified_at = "2020-06-19 21:16:08"
    git_last_modified_by = "Adin.Ermie@outlook.com"
    git_modifiers        = "Adin.Ermie/nimrodkor"
    git_org              = "eurogig"
    git_repo             = "terragoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "interfaces"
    yor_trace            = "15d1d36a-9c94-41ba-9a32-a8b5a7055c11"
  }
}