terraform {
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
#  config_context = "my-context"
}