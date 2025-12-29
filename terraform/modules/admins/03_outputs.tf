output "admin_group_id" {
  value       = azuread_group.aks_admins.id
  description = "Azure AD admin group resource ID"
}