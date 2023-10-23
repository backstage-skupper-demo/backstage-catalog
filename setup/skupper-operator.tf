resource "kubernetes_manifest" "gitops" {
  manifest = {
    apiVersion    = "operators.coreos.com/v1alpha1"
    kind          = "Subscription"
    metadata      = {
      name      = "skupper-operator"
      namespace = "openshift-operators"
    }

    spec = {
      channel             = "alpha"
      installPlanApproval = "Automatic"
      name                = "skupper-operator"
      source              = "redhat-operators"
      sourceNamespace     = "openshift-marketplace"
    }
  }
}