data "google_compute_network" "shared_vpc" {
  name    =  var.shared_vpc_network
  project = data.google_project.host_project.project_id
}

resource "google_compute_subnetwork" "subnet" {
  count         = length(var.subnets) 

  name          = var.subnets[count.index].name
  ip_cidr_range = var.subnets[count.index].primary_range
  region        = var.subnets[count.index].region
  project       = data.google_project.host_project.project_id
  network       = data.google_compute_network.shared_vpc.name

  private_ip_google_access = true

  dynamic "secondary_ip_range" {
    for_each = var.subnets[count.index].secondary_range
    content {
      range_name    = secondary_ip_range.key
      ip_cidr_range = secondary_ip_range.value
    }
  }
}

resource "google_compute_subnetwork_iam_member" "subnet_user" {
  depends_on = [
    google_project_service.service_project_api,
  ]

  count       = length(var.subnet_users) * length(var.subnets)
  project     = data.google_project.host_project.project_id
  region      = google_compute_subnetwork.subnet[count.index % length(var.subnet_users)].region
  subnetwork  = google_compute_subnetwork.subnet[count.index % length(var.subnet_users)].name
  role        = "roles/compute.networkUser"
  member      = format("serviceAccount:%s", var.subnet_users[count.index % length(var.subnets)])
}

resource "google_compute_subnetwork_iam_member" "container_network_user_additional" {
  depends_on = [
    google_project_service.service_project_api,
  ]

  count       = length(var.subnets)
  project     = data.google_project.host_project.project_id
  region      = google_compute_subnetwork.subnet[count.index].region
  subnetwork  = google_compute_subnetwork.subnet[count.index].name
  role        = "roles/compute.networkUser"
  member      = format("serviceAccount:service-%d@container-engine-robot.iam.gserviceaccount.com", local.project_number)
}

resource "google_compute_subnetwork_iam_member" "cloudservices_network_user_additional" {
  depends_on = [
    google_project_service.service_project_api,
  ]

  count       = length(var.subnets) 
  project     = data.google_project.host_project.project_id
  region      = google_compute_subnetwork.subnet[count.index].region
  subnetwork  = google_compute_subnetwork.subnet[count.index].name
  role        = "roles/compute.networkUser"
  member      = format("serviceAccount:%d@cloudservices.gserviceaccount.com", local.project_number)
}

