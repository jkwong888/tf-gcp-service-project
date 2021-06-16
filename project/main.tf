locals {
    project_id = "${var.billing_account_id != "" ? 
        google_project.project[0].project_id : 
        data.google_project.project[0].project_id}"

    project_number = "${var.billing_account_id != "" ? 
        google_project.project[0].number : 
        data.google_project.project[0].number}"
}

data "google_billing_account" "acct" {
    count = var.billing_account_id != "" ? 1 : 0
    billing_account = var.billing_account_id
}

data "google_folder" "parent_folder" {
    count = var.billing_account_id != "" ? 1 : 0
    folder = format("folders/%s", var.parent_folder_id)
}

resource "google_project" "project" {
    count = var.billing_account_id != "" ? 1 : 0

    name                = var.project_id
    project_id          = var.project_id
    folder_id           = data.google_folder.parent_folder[0].id
    billing_account     = data.google_billing_account.acct[0].billing_account
    auto_create_network =  false
}

data "google_project" "project" {
  count = var.billing_account_id != "" ? 0 : 1

  project_id = var.project_id
}

resource "google_project_service" "service_project_api" {
  count                      = length(var.apis_to_enable)
  project                    = local.project_id
  service                    = element(var.apis_to_enable, count.index)
  disable_on_destroy         = false
  disable_dependent_services = false
}