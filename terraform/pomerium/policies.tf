variable "policy_dir" {
  default = "policies" # Directory containing the YAML policies
}

locals {
  yaml_files   = fileset(var.policy_dir, "*.yaml")                            # Get all YAML files
  policy_names = { for f in local.yaml_files : replace(f, ".yaml", "") => f } # Extract policy names
}

### COMMENTED OUT UNTIL YAML PARSING IS FIXED
# resource "pomerium_policy" "policies" {
#   for_each = local.policy_names

#   name         = each.key
#   namespace_id = pomerium_namespace.demo.id
#   ppl          = file("${var.policy_dir}/${each.value}") # Load the YAML file content
# }

# output "policies_created" {
#   value = { for k, v in pomerium_policy.policies : k => v.name }
# }

resource "pomerium_policy" "allow_pomerium" {
  name         = "allow_pomerium"
  namespace_id = pomerium_namespace.demo.id
  ppl          = <<EOF
- allow:
    and:
      - domain:
          is: pomerium.com
EOF
}

resource "pomerium_policy" "allow_ops" {
  name         = "allow_ops"
  namespace_id = pomerium_namespace.demo.id
  ppl          = <<EOF
allow:
  and:
    - claim/group: ops
EOF
}

resource "pomerium_policy" "allow_sales" {
  name         = "allow_sales"
  namespace_id = pomerium_namespace.demo.id
  ppl          = <<EOF
allow:
  and:
    - claim/group: sales
EOF
}