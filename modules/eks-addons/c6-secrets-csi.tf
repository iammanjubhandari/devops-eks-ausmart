# secrets store CSI - mounts Secrets Manager secrets into pods as volumes
resource "helm_release" "secrets_store_csi" {
  name       = "secrets-store-csi-driver"
  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart      = "secrets-store-csi-driver"
  namespace  = "kube-system"
  version    = "1.4.1"

  depends_on = [aws_eks_addon.pod_identity]
}
