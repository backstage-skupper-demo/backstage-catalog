provider "gitlab" {
  token = var.gitlab_token
}

data "gitlab_project" "software-templates" {
  path_with_namespace = "rhdh/software-templates"
}

resource "gitlab_repository_file" "this" {
  project        = data.gitlab_project.software-templates.id
  file_path      = "showcase-templates.yaml"
  branch         = "main"
  content        = base64encode(file("templates.yaml"))
  author_email   = "terraform@example.com"
  author_name    = "Terraform"
  commit_message = "feature: add meow file"
  overwrite_on_create = true
}

resource "gitlab_repository_file" "laptop_rest_client" {
  project        = data.gitlab_project.software-templates.id
  file_path      = "scaffolder-templates/quarkus-web-template/skeleton/src/main/java/${"$"}{{values.java_package_name}}/LaptopRestClient.java"
  branch         = "main"
  content        = base64encode(file("quarkus-additions/LaptopRestClient.java"))
  author_email   = "terraform@example.com"
  author_name    = "Terraform"
  commit_message = "feature: add meow file"
  overwrite_on_create = true
}

resource "gitlab_repository_file" "vm_rest_client" {
  project        = data.gitlab_project.software-templates.id
  file_path      = "scaffolder-templates/quarkus-web-template/skeleton/src/main/java/${"$"}{{values.java_package_name}}/VmRestClient.java"
  branch         = "main"
  content        = base64encode(file("quarkus-additions/VmRestClient.java"))
  author_email   = "terraform@example.com"
  author_name    = "Terraform"
  commit_message = "feature: add meow file"
  overwrite_on_create = true
}

resource "gitlab_repository_file" "vm_rest_resource" {
  project        = data.gitlab_project.software-templates.id
  file_path      = "scaffolder-templates/quarkus-web-template/skeleton/src/main/java/${"$"}{{values.java_package_name}}/VmRestResource.java"
  branch         = "main"
  content        = base64encode(file("quarkus-additions/VmRestResource.java"))
  author_email   = "terraform@example.com"
  author_name    = "Terraform"
  commit_message = "feature: add meow file"
  overwrite_on_create = true
}

resource "gitlab_repository_file" "application_properties" {
  project        = data.gitlab_project.software-templates.id
  file_path      = "scaffolder-templates/quarkus-web-template/skeleton/src/main/resources/application.properties"
  branch         = "main"
  content        = base64encode(file("quarkus-additions/application.properties"))
  author_email   = "terraform@example.com"
  author_name    = "Terraform"
  commit_message = "feature: add meow file"
  overwrite_on_create = true
}

resource "gitlab_repository_file" "pom_xml" {
  project        = data.gitlab_project.software-templates.id
  file_path      = "scaffolder-templates/quarkus-web-template/skeleton/pom.xml"
  branch         = "main"
  content        = base64encode(file("quarkus-additions/pom.xml"))
  author_email   = "terraform@example.com"
  author_name    = "Terraform"
  commit_message = "feature: add meow file"
  overwrite_on_create = true
}

resource "gitlab_repository_file" "values_yaml" {
  project        = data.gitlab_project.software-templates.id
  file_path      = "scaffolder-templates/quarkus-web-template/manifests/helm/app/values.yaml"
  branch         = "main"
  content        = base64encode(file("quarkus-additions/values.yaml"))
  author_email   = "terraform@example.com"
  author_name    = "Terraform"
  commit_message = "feature: add meow file"
  overwrite_on_create = true
}
