resource "kubernetes_namespace" "skupper" {
  metadata {
    name = "skupper"
    labels = {
      "argocd.argoproj.io/managed-by" = "openshift-gitops"
    }
  }
}

resource "kubernetes_secret" "ssh-key" {
  metadata {
    name      = "vm-ssh-key"
    namespace = "skupper"
  }

  data = {
    ssh-key = tls_private_key.skuppervm.private_key_openssh
  }

  depends_on = [ kubernetes_namespace.skupper ]
}


resource "kubernetes_cluster_role_binding" "pipeline-admin" {
  metadata {
    name      = "skupper-pipeline-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "pipeline"
    namespace = "skupper"
  }

  depends_on = [ kubernetes_namespace.skupper ]
}