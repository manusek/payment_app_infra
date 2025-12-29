data "azuread_client_config" "current" {}

resource "azuread_group" "aks_admins" {
  display_name     = "aks-paymentapp-admins-dev"
  security_enabled = true
}

resource "azuread_group_member" "group_member" {
  group_object_id  = azuread_group.aks_admins.object_id
  member_object_id = data.azuread_client_config.current.object_id
}