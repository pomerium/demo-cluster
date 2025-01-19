locals {
  base_domain = "pomerium.dev"
}
resource "pomerium_route" "kubernetes" {
  name         = "kubernetes"
  from         = format("https://%s.%s", "k8s", local.base_domain)
  to           = ["https://kubernetes.default.svc.cluster.local"]
  namespace_id = pomerium_namespace.demo.id
  policies     = [pomerium_policy.allow_pomerium.id]

  allow_websockets = true
  allow_spdy       = true

  set_request_headers = {
    Authorization = "Bearer $${pomerium.jwt}"
  }
}

resource "pomerium_route" "argocd" {
  name         = "argocd"
  from         = format("https://%s.%s", "argocd", local.base_domain)
  to           = ["https://argocd-server.argocd.svc.cluster.local"]
  namespace_id = pomerium_namespace.demo.id
  policies     = [pomerium_policy.allow_pomerium.id]

  allow_websockets = true
  allow_spdy       = true
}

resource "pomerium_route" "guacamole" {
  name         = "guacamole"
  from         = format("https://%s.%s", "guacamole", local.base_domain)
  to           = ["http://guacamole.guacamole.svc.cluster.local"]
  namespace_id = pomerium_namespace.demo.id
  policies     = [pomerium_policy.allow_pomerium.id]

  allow_websockets      = true
  allow_spdy            = true
  pass_identity_headers = true
}
