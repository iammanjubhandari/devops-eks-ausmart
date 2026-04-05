# secrets store CSI - mounts Secrets Manager secrets into pods as volumes
# pods get a SecretProviderClass that points at a SM secret
# CSI fetches it at startup using pod identity, creates a k8s secret from it
resource "helm_release" "secrets_store_csi" {
  name       = "secrets-store-csi-driver"
  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart      = "secrets-store-csi-driver"
  namespace  = "kube-system"
  version    = "1.4.1"

  # need syncSecret so CSI creates actual k8s secrets from SM values
  set {
    name  = "syncSecret.enabled"
    value = "true"
  }

  set {
    name  = "enableSecretRotation"
    value = "true"
  }

  depends_on = [aws_eks_addon.pod_identity]
}

# AWS provider - this is what actually talks to Secrets Manager
# CSI driver is generic, this makes it AWS-aware
resource "helm_release" "secrets_provider_aws" {
  name       = "secrets-store-csi-driver-provider-aws"
  repository = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
  chart      = "secrets-store-csi-driver-provider-aws"
  namespace  = "kube-system"
  version    = "0.3.6"

  depends_on = [helm_release.secrets_store_csi]
}
