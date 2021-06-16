data "google_project" "host_project" {
  project_id = var.shared_vpc_host_project_id
}

module "service_project" {
  source = "./project"

  org_id              = var.organization_id
  billing_account_id  = var.billing_account_id
  project_id          = var.service_project_id
  parent_folder_id    = var.service_project_parent_folder_id

  apis_to_enable      = var.service_project_apis_to_enable
}

resource "google_compute_shared_vpc_service_project" "shared_vpc_attachment" {
  host_project    = data.google_project.host_project.project_id
  service_project = module.service_project.project_id

  depends_on = [
    module.service_project.enabled_apis,
  ]
}

