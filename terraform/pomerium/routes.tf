locals {
  base_domain = "pomerium.dev"
}
resource "pomerium_route" "kubernetes" {
  name         = "kubernetes"
  from         = format("https://%s.%s", "k8s", local.base_domain)
  to           = ["https://kubernetes.default.svc.cluster.local"]
  namespace_id = pomerium_namespace.demo.id
  policies     = [pomerium_policy.allow_pomerium.id]

  tls_skip_verify       = true
  allow_websockets      = true
  allow_spdy            = true
  pass_identity_headers = true

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

  tls_skip_verify  = true
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

resource "pomerium_route" "grafana" {
  name         = "grafana"
  from         = format("https://%s.%s", "grafana", local.base_domain)
  to           = ["http://prometheus-grafana.default.svc.cluster.local"]
  namespace_id = pomerium_namespace.demo.id
  policies     = [pomerium_policy.allow_pomerium.id]

  pass_identity_headers = true

  allow_websockets = true
  allow_spdy       = true
}

resource "pomerium_route" "verify" {
  from                  = format("https://%s.%s", "verify", local.base_domain)
  to                    = ["https://verify.pomerium.com"]
  name                  = "verify"
  namespace_id          = pomerium_namespace.demo.id
  pass_identity_headers = true
  policies              = [pomerium_policy.allow_pomerium.id]
}

resource "pomerium_route" "prometheus" {
  name         = "prometheus"
  from         = format("https://%s.%s", "prometheus", local.base_domain)
  to           = ["http://prometheus-server.prometheus.svc.cluster.local"]
  namespace_id = pomerium_namespace.demo.id
  policies     = [pomerium_policy.allow_pomerium.id]

  allow_websockets = true
  allow_spdy       = true
}