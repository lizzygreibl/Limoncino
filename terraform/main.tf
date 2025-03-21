# Create a resource group
resource "azurerm_resource_group" "lizzy" {
  name     = "lizzyressource"
  location = "West Europe"

  tags = {
    owner = "elisabeth.greibl@redbull.com"
  }
}

#comment commit
resource "azurerm_resource_group" "bapt" {
  name     = "baptressource"
  location = "West Europe"

  tags = {
    owner = "Baptiste.Achard@redbull.com"
  }
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "lizzy" {
  name                = "lizzy-vnet"
  resource_group_name = azurerm_resource_group.lizzy.name
  location            = azurerm_resource_group.lizzy.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "lizzy" {
  name                 = "lizzy-subnet"
  resource_group_name  = azurerm_resource_group.lizzy.name
  virtual_network_name = azurerm_virtual_network.lizzy.name
  address_prefixes     = ["10.0.1.0/24"]

  
}


# Create a virtual network within the resource group
resource "azurerm_virtual_network" "bapt" {
  name                = "bapt-vnet"
  resource_group_name = azurerm_resource_group.bapt.name
  location            = azurerm_resource_group.bapt.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "bapt" {
  name                 = "bapt-subnet"
  resource_group_name  = azurerm_resource_group.bapt.name
  virtual_network_name = azurerm_virtual_network.bapt.name
  address_prefixes     = ["10.0.1.0/24"]

  
}

# Define the network interface

resource "azurerm_network_interface" "lizzy-nic" {
  name                = "lizzy-nic"
  location            = azurerm_resource_group.lizzy.location
  resource_group_name = azurerm_resource_group.lizzy.name

  ip_configuration {
    name                          = "lizzy-ipcfg"
    subnet_id                     = azurerm_subnet.lizzy.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Define the network interface

resource "azurerm_network_interface" "bapt-nic" {
  name                = "bapt-nic"
  location            = azurerm_resource_group.bapt.location
  resource_group_name = azurerm_resource_group.bapt.name

  ip_configuration {
    name                          = "bapt-ipcfg"
    subnet_id                     = azurerm_subnet.bapt.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Define the virtual machine
resource "azurerm_linux_virtual_machine" "lizzyvm" {
  name                = "lizzy-vm"
  location            = azurerm_resource_group.lizzy.location
  resource_group_name = azurerm_resource_group.lizzy.name
  network_interface_ids = [
    azurerm_network_interface.lizzy-nic.id,
  ]
  size               = "Standard_DS1_v2"
  admin_username     = "username"
  admin_password     = "34FDA$#214f"  # For demonstration purposes only. Use secure methods for production.
  disable_password_authentication = "false"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}


# Define the virtual machine
resource "azurerm_linux_virtual_machine" "baptvm" {
  name                = "bapt-vm"
  location            = azurerm_resource_group.bapt.location
  resource_group_name = azurerm_resource_group.bapt.name
  network_interface_ids = [
    azurerm_network_interface.bapt-nic.id,
  ]
  size               = "Standard_DS1_v2"
  admin_username     = "username"
  admin_password     = "34FDA$#214f"  # For demonstration purposes only. Use secure methods for production.
  disable_password_authentication = "false"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
