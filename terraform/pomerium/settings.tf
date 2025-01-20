resource "pomerium_settings" "settings" {
  jwt_claims_headers = {
    "X-Pomerium-Claim-Email" = "email"
  }
}