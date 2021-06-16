output "project_id" {
    value = local.project_id
}

output "number" {
    value = local.project_number
}

output "enabled_apis" {
    value = google_project_service.service_project_api[*].service
}

output "subnets" {
    value = google_compute_subnetwork.subnet
}