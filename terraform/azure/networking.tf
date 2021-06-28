resource "azurerm_virtual_network" "example" {
  name                = "terragoat-vn-${var.environment}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tags = {
    git_commit           = "2384d4d87f0d949f4e7c31718827a92ad9fdc27d"
    git_file             = "terraform/azure/networking.tf"
    git_last_modified_at = "2021-06-17 14:08:57"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "6a4dbb61-6a9b-48d0-a821-288932346475"
  }
}

resource "azurerm_subnet" "example" {
  name                 = "terragoat-${var.environment}"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_network_interface" "ni_linux" {
  name                = "terragoat-linux-${var.environment}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = {
    git_commit           = "2384d4d87f0d949f4e7c31718827a92ad9fdc27d"
    git_file             = "terraform/azure/networking.tf"
    git_last_modified_at = "2021-06-17 14:08:57"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "f353661d-9793-46a7-8dd0-1102a6fc5506"
  }
}

resource "azurerm_network_interface" "ni_win" {
  name                = "terragoat-win-${var.environment}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = {
    git_commit           = "2384d4d87f0d949f4e7c31718827a92ad9fdc27d"
    git_file             = "terraform/azure/networking.tf"
    git_last_modified_at = "2021-06-17 14:08:57"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "d9c1f249-025c-4f7c-a834-410668c12671"
  }
}

resource azurerm_network_security_group "bad_sg" {
  location            = var.location
  name                = "terragoat-${var.environment}"
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "AllowSSH"
    priority                   = 200
    protocol                   = "TCP"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_port_range     = "22-22"
    destination_address_prefix = "*"
  }

  security_rule {
    access                     = "Allow"
    direction                  = "Inbound"
    name                       = "AllowRDP"
    priority                   = 300
    protocol                   = "TCP"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_port_range     = "3389-3389"
    destination_address_prefix = "*"
  }
  tags = {
    git_commit           = "2384d4d87f0d949f4e7c31718827a92ad9fdc27d"
    git_file             = "terraform/azure/networking.tf"
    git_last_modified_at = "2021-06-17 14:08:57"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "4c9ceffd-a877-4816-9ffe-34120a07437e"
  }
}

resource azurerm_network_watcher "network_watcher" {
  location            = var.location
  name                = "terragoat-network-watcher-${var.environment}"
  resource_group_name = azurerm_resource_group.example.name
  tags = {
    git_commit           = "2384d4d87f0d949f4e7c31718827a92ad9fdc27d"
    git_file             = "terraform/azure/networking.tf"
    git_last_modified_at = "2021-06-17 14:08:57"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
    level                = "production"
    pci-dss              = "true"
    team                 = "platform"
    yor_trace            = "ce985d60-7885-4125-a5fe-72e31f13433d"
  }
}

resource azurerm_network_watcher_flow_log "flow_log" {
  enabled                   = false
  network_security_group_id = azurerm_network_security_group.bad_sg.id
  network_watcher_name      = azurerm_network_watcher.network_watcher.name
  resource_group_name       = azurerm_resource_group.example.name
  storage_account_id        = azurerm_storage_account.example.id
  retention_policy {
    enabled = false
    days    = 10
  }
  tags = {
    yor_trace            = "1564fb82-0752-4f92-888e-8abcd5db55f8"
    git_commit           = "2384d4d87f0d949f4e7c31718827a92ad9fdc27d"
    git_file             = "terraform/azure/networking.tf"
    git_last_modified_at = "2021-06-17 14:08:57"
    git_last_modified_by = "eurogig@gmail.com"
    git_modifiers        = "eurogig"
    git_org              = "eurogig"
    git_repo             = "demogoat"
  }
}