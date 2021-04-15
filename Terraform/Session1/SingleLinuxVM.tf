# Configure the Microsoft Azure Provider
provider "azurerm" {
    features {}
}

# Create resource groups if they don't exist
resource "azurerm_resource_group" "myterraformgroup" {
    name     = "rg-linux-vm"
    location = "usgovvirginia"

    tags = {
        environment = "Litware Reqmnt"
    }
}

resource "azurerm_resource_group" "myterraformgroup2" {
    name     = "rg-linux-vm2"
    location = "usgovvirginia"

    tags = {
        environment = "Litware Reqmnt"
    }
}

# Create virtual network
resource "azurerm_virtual_network" "myterraformnetwork" {
    name                = "vnet-litreq-va-001"
    address_space       = ["10.20.0.0/16"]
    location            = "usgovvirginia"
    resource_group_name = azurerm_resource_group.myterraformgroup.name

    tags = {
        environment = "Litware Reqmnt"
    }
}

resource "azurerm_virtual_network" "myterraformnetwork2" {
    name                = "vnet-litreq-va-002"
    address_space       = ["10.21.0.0/16"]
    location            = "usgovvirginia"
    resource_group_name = azurerm_resource_group.myterraformgroup2.name

    tags = {
        environment = "Litware Reqmnt"
    }
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {
    name                 = "snet-rhel-vms"
    resource_group_name  = azurerm_resource_group.myterraformgroup.name
    virtual_network_name = azurerm_virtual_network.myterraformnetwork.name
    address_prefixes       = ["10.20.1.0/24"]
}

resource "azurerm_subnet" "myterraformsubnet2" {
    name                 = "snet-rhel-vms"
    resource_group_name  = azurerm_resource_group.myterraformgroup2.name
    virtual_network_name = azurerm_virtual_network.myterraformnetwork2.name
    address_prefixes       = ["10.21.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "myterraformpublicip" {
    name                         = "pip-vmrhel-001"
    location                     = "usgovvirginia"
    resource_group_name          = azurerm_resource_group.myterraformgroup.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "Litware Reqmnt"
    }
}

resource "azurerm_public_ip" "myterraformpublicip2" {
    name                         = "pip-vmrhel-002"
    location                     = "usgovvirginia"
    resource_group_name          = azurerm_resource_group.myterraformgroup2.name
    allocation_method            = "Dynamic"

    tags = {
        environment = "Litware Reqmnt"
    }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
    name                = "nsg-linux-ssh"
    location            = "usgovvirginia"
    resource_group_name = azurerm_resource_group.myterraformgroup.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "Litware Reqmnt"
    }
}

# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
    name                      = "nic-vmrhel-001"
    location                  = "usgovvirginia"
    resource_group_name       = azurerm_resource_group.myterraformgroup.name

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = azurerm_subnet.myterraformsubnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
    }

    tags = {
        environment = "Litware Reqmnt"
    }
}

resource "azurerm_network_interface" "myterraformnic2" {
    name                      = "nic-vmrhel-002"
    location                  = "usgovvirginia"
    resource_group_name       = azurerm_resource_group.myterraformgroup2.name

    ip_configuration {
        name                          = "myNicConfiguration2"
        subnet_id                     = azurerm_subnet.myterraformsubnet2.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.myterraformpublicip2.id
    }

    tags = {
        environment = "Litware Reqmnt"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.myterraformnic.id
    network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        resource_group = azurerm_resource_group.myterraformgroup.name
    }

    byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "mystorageaccount" {
    name                        = "diag${random_id.randomId.hex}"
    resource_group_name         = azurerm_resource_group.myterraformgroup.name
    location                    = "usgovvirginia"
    account_tier                = "Standard"
    account_replication_type    = "LRS"

    tags = {
        environment = "Litware Reqmnt"
    }
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
    name                  = "vmRHEL-001"
    location              = "usgovvirginia"
    resource_group_name   = azurerm_resource_group.myterraformgroup.name
    network_interface_ids = [azurerm_network_interface.myterraformnic.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        name              = "RhelOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "RedHat"
        offer     = "RHEL"
        sku       = "7.8"
        version   = "latest"
    }

    computer_name  = "vmrhel-001"
    admin_username = "azureuser"
    admin_password = "Password123!!"
    disable_password_authentication = false
    allow_extension_operations = true
    

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.mystorageaccount.primary_blob_endpoint
    }

    tags = {
        environment = "Litware Reqmnt"
    }
}
