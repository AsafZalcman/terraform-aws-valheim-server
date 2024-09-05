variable "artifactory_url" {
  type = string
}

variable "artifactory_access_token" {
  type = string
}

variable "local_repo_list" {
  type    = list(string)
  default = ["pypi-local"]
}

variable "remote_repo_list" {
  type    = map(string)
  default = { pypi-remote = "https://files.pythonhosted.org" }
}

variable "virtual_repo" {
  type    = string
  default = "pypi-virtual"
  }

