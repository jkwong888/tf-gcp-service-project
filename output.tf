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

output "subnet_users" {
    value = concat(
        google_compute_subnetwork_iam_member.subnet_user.*.member,
        tolist(google_compute_subnetwork_iam_member.container_network_user_additional.member),
        tolist(google_compute_subnetwork_iam_member.cloudservices_network_user_additional.member)
    )
}