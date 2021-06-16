variable "billing_account_id" {}

variable "project_id" {}

variable "org_id" {}

variable "parent_folder_id" {}

variable "apis_to_enable" {
  type = list(string)
  default = [
    "container.googleapis.com",
    "compute.googleapis.com",
  ]
}