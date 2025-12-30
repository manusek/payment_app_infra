data "azuread_client_config" "current" {}

# tworzenie grupy aks-admin i dodawanie current usera, bez tego uzytkownik nie moze poloaczyc sie do aks ani zarzadzac klastrem
resource "azuread_group" "aks_admins" {
  display_name     = "aks-paymentapp-admins-dev"
  security_enabled = true
}

resource "azuread_group_member" "group_member" {
  group_object_id  = azuread_group.aks_admins.object_id
  member_object_id = data.azuread_client_config.current.object_id
}