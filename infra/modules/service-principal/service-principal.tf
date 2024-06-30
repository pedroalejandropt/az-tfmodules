resource "azuread_service_principal" "sp" {
  application_id               = var.ad_app_id
  app_role_assignment_required = false
}

resource "azuread_service_principal_password" "sp_pass" {
  service_principal_id = azuread_service_principal.sp.id
  value                = random_string.sp_password.result
  end_date_relative    = "8760h" # 1 year

  lifecycle {
    ignore_changes = [
      value,
      end_date_relative
    ]
  }
}

resource "azuread_application_password" "ad_app_pass" {
  application_object_id = azuread_application.sp.id
  value                 = random_string.sp_secret.result
  end_date_relative     = "8760h" # 1 year

  lifecycle {
    ignore_changes = [
      value,
      end_date_relative
    ]
  }
}