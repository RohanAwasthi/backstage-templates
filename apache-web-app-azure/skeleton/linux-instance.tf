resource "azurerm_network_interface" "terra-demo" {
  name                = "${{ values.component_id }}"
  location            = azurerm_resource_group.terra-demo.location
  resource_group_name = azurerm_resource_group.terra-demo.name

  ip_configuration {
    name                          = "internal"
    #subnet_id                     = azurerm_subnet.terra-demo.id
    subnet_id                     = "USEPSBXDNTSBN01"
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.terra-demo.id
  }
}

resource "azurerm_linux_virtual_machine" "terra-demo" {
  name                = "${{ values.component_id }}"
  # name                = "terra-machine01-.NET"
  resource_group_name = azurerm_resource_group.terra-demo.name
  location            = azurerm_resource_group.terra-demo.location
  # size                = ${{ values.vm_size }}
  size                  = var.size
  # size                = "Standard_D2_v2"
  admin_username      = "azureuser"
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.terra-demo.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")  
    
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    
    publisher = "Canonical"
  # offer     = ${{ values.vm_publisher }}
    offer      =    var.offer
    sku       = "18.04-LTS"
    version   = "latest"
    # publisher = "Canonical"
    # offer     = "UbuntuServer"
    # sku       = "16.04-LTS"
    # version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "terra-demo" {
  name                 = "hostname"
  virtual_machine_id   = azurerm_linux_virtual_machine.terra-demo.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
 {
  "commandToExecute": "sudo apt-get update && sudo apt-get install apache2 -y && sudo systemctl start apache2 && sudo systemctl enable apache2 && sudo echo '<h1>Hello World from Terraform</h1>' | sudo tee /var/www/html/index.html"
 }
SETTINGS

  tags = {
    environment = "Production"
  }
}
