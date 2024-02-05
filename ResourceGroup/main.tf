# In this module, the Resource Group for the demo is created as well as Azure Entra ID groups with needed permissions 
# that are explained below. After that, the Service Principal is created.
#
# This assumes, that there is Service Principal created beforehand.

# Lets read Subscription and client information for the later use:
data "azurerm_client_config" "current_config" {}
data "azurerm_subscription" "current_subscription" {}

# Creation of the Resource Group. Resource Group name is given in the main.tf that calls the module and works as the name constructor.
resource "azurerm_resource_group" "rg" {
  name     = "${var.name_construct}RG"
  location = var.region
}

# Creation of the Azure Entra ID group for Owners
resource "azuread_group" "owner_group" {
  display_name     = "AAD-${data.azurerm_subscription.current_subscription.display_name}-${var.name_construct}-Owners"
  owners           = [data.azurerm_client_config.current_config.object_id]
  security_enabled = true
  description      = "Owner group in Entra ID"
}

# Assigning Owner role for the Owners group
resource "azurerm_role_assignment" "owner_group_assignment" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Owner"
  principal_id         = azuread_group.owner_group.id
  description          = "Granting Owner role for the Service Principal in the AAD-${data.azurerm_subscription.current_subscription.display_name}-${var.name_construct}-Owners"
}



# Creation of the Azure Entra ID group for Contributors
resource "azuread_group" "contributor_group" {
  display_name     = "AAD-${data.azurerm_subscription.current_subscription.display_name}-${var.name_construct}-Contributors"
  owners           = [data.azurerm_client_config.current_config.object_id]
  security_enabled = true
  description      = "Contributor group in Entra ID"
}

# Assigning Contributor role for the Contributors group
resource "azurerm_role_assignment" "contributors_group_assignment" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = azuread_group.contributor_group.id
  description          = "Granting Contributor role for the Service Principal in the AAD-${data.azurerm_subscription.current_subscription.display_name}-${var.name_construct}-Contributors"
}



# Creation of the Azure Entra ID group for Readers
resource "azuread_group" "reader_group" {
  display_name     = "AAD-${data.azurerm_subscription.current_subscription.display_name}-${var.name_construct}-Readers"
  owners           = [data.azurerm_client_config.current_config.object_id]
  security_enabled = true
  description      = "Reader group in Entra ID"
}

# Assigning Reader role for the Readers group
resource "azurerm_role_assignment" "readers_group_assignment" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Reader"
  principal_id         = azuread_group.reader_group.id
  description          = "Granting Reader role for the Service Principal in the AAD-${data.azurerm_subscription.current_subscription.display_name}-${var.name_construct}-Readers"
}



# Creation of the Azure Entra ID group for Key Vault Secrets Officers (needed to access Key Vault properly)
resource "azuread_group" "kv_secrets_officers_group" {
  display_name     = "AAD-${data.azurerm_subscription.current_subscription.display_name}-${var.name_construct}-KV-Secrets-Officers"
  owners           = [data.azurerm_client_config.current_config.object_id]
  security_enabled = true
  description      = "Key Vault Secrets Officers group in Entra ID"
}

# Assigning Key Vault Secrets Officer role for the group
resource "azurerm_role_assignment" "kv_secrets_officers_group_assignment" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = azuread_group.kv_secrets_officers_group.id
  description          = "Granting KV Secrets Officer role for the Service Principal in the AAD-${data.azurerm_subscription.current_subscription.display_name}-${var.name_construct}-KV-Secrets-Officers"
}

# And now add the current service principal as the member of Key Vault Secrets Officer group in order to manage Key Vault
resource "azuread_group_member" "terra_spn_kv" {
  group_object_id  = azuread_group.kv_secrets_officers_group.id
  member_object_id = data.azurerm_client_config.current_config.object_id
}

