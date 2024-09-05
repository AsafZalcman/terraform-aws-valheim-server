terraform {
  required_providers {
    artifactory = {
      source  = "jfrog/artifactory"
      version = "10.6.2"
    }
  }
}

# Configure the Artifactory provider
provider "artifactory" {
  url          = "${var.artifactory_url}/artifactory"
  access_token = var.artifactory_access_token
}


# Create local pypi repos
resource "artifactory_local_pypi_repository" "pypi-locals" {
  for_each        = toset(var.local_repo_list)
  key             = each.value
  repo_layout_ref = "simple-default"
  description     = "A pypi repository for python packages"
}

# Create remote pypi repos
resource "artifactory_remote_pypi_repository" "pypi-remotes" {
  for_each               = var.remote_repo_list
  key                    = each.key
  url                    = each.value
  pypi_registry_url      = "https://pypi.org"
  pypi_repository_suffix = "simple"
}


# Create virtual pypi repos
resource "artifactory_virtual_pypi_repository" "pypi-virtuals" {
  key              = var.virtual_repo
  repositories     = concat(var.local_repo_list, keys(var.remote_repo_list))
  description      = "A test virtual repo"
  notes            = "Internal description"
  includes_pattern = "com/jfrog/**,cloud/jfrog/**"
  excludes_pattern = "com/google/**"
}
