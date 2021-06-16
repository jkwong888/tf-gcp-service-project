#billing_account_id = "01B461-A61180-9BE3B2"

shared_vpc_host_project_id = "jkwng-nonprod-vpc"
shared_vpc_network = "shared-vpc-nonprod-1"

service_project_id = "jkwng-fruitshop-dev"
registry_project_id = "jkwng-images"

gke_cluster_name = "fruitshop-dev-central"
gke_cluster_master_range = "10.0.2.0/28"
gke_default_nodepool_machine_type = "e2-standard-2"

subnets = [
{
    name = "dev-central1"
    primary_range = "10.0.0.0/24"
    region = "us-central1"
    secondary_range = {
      "pods" = "10.100.0.0/16",
      "services" = "10.0.1.0/24",
    }
  },
  {
    name = "dev-east1"
    primary_range = "10.1.0.0/24"
    region = "us-east1"
    secondary_range = {
      "pods" = "10.101.0.0/16",
      "services" = "10.1.1.0/24",
    }
  },
  {
    name = "dev-west1"
    primary_range = "10.2.0.0/24"
    region = "us-west1"
    secondary_range = {
      "pods" = "10.102.0.0/16",
      "services" = "10.2.1.0/24",
    }
  },
]

service_project_apis_to_enable = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "multiclusteringress.googleapis.com",
    "multiclusterservicediscovery.googleapis.com",
    "gkehub.googleapis.com",
    "dns.googleapis.com",
    "trafficdirector.googleapis.com",
    "cloudresourcemanager.googleapis.com",
]

subnet_users = [
]


