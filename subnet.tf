locals {
    subnet_name = var.create_subnet ? google_compute_subnetwork.subnet[0].name : data.google_compute_subnetwork.subnet[0].name
    subnet_self_link = var.create_subnet ? google_compute_subnetwork.subnet[0].self_link : data.google_compute_subnetwork.subnet[0].self_link
}

data "google_compute_network" "shared_vpc" {
  name =  var.shared_vpc_network
  project = data.google_project.host_project.project_id
}

resource "google_compute_subnetwork" "subnet" {
  count         = var.create_subnet ? 1 : 0
  name          = var.subnet_name
  ip_cidr_range = var.subnet_primary_range
  region        = var.subnet_region
  project       = data.google_project.host_project.project_id
  network       = data.google_compute_network.shared_vpc.name

  private_ip_google_access = true

  dynamic "secondary_ip_range" {
    for_each = var.subnet_secondary_range
    content {
      range_name    = secondary_ip_range.key
      ip_cidr_range = secondary_ip_range.value
    }
  }
}

data "google_compute_subnetwork" "subnet" {
  count         = var.create_subnet ? 0 : 1
  name          = var.subnet_name
  region        = var.subnet_region
  project       = data.google_project.host_project.project_id
}
