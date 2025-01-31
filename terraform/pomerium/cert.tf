# # Kubernetes cluster public certificate

# # kubectl get configmap kube-root-ca.crt -o=jsonpath='{.data.ca\.crt}'
# resource "pomerium_key_pair" "kubernetes-api" {
#   name         = "k8s-cluster"
#   namespace_id = pomerium_namespace.demo.id
#   certificate  = file("certificates/k8s-demo.crt")
# }

# # kubectl get secret argocd-secret -n argocd -o jsonpath='{.data.tls\.crt}' | base64 --decode > argocd-tls.crt
# resource "pomerium_key_pair" "argocd" {
#   name         = "argocd-cluster"
#   namespace_id = pomerium_namespace.demo.id
#   certificate  = file("certificates/argocd.crt")
# }