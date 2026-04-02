# Agent Instructions (Repo-Specific)
This repository is primarily **Terraform IaC** for an AWS scalable web architecture.

No Cursor rules were found in `.cursor/rules/` or `.cursorrules`. No GitHub Copilot instructions were found in `.github/copilot-instructions.md`.

## Quick Commands (Build / Lint / Test)
All Terraform code lives under `Terraform/`.

```bash
# Format (write changes)
terraform -chdir=Terraform fmt -recursive

# Format check (CI-style)
terraform -chdir=Terraform fmt -check -diff -recursive

# Init (safe for validation/CI; avoids remote backend prompts)
terraform -chdir=Terraform init -backend=false -input=false

# Validate
terraform -chdir=Terraform validate

# Plan (requires AWS credentials and any backend/state config you use)
terraform -chdir=Terraform plan -input=false

# Apply / Destroy
terraform -chdir=Terraform apply
terraform -chdir=Terraform destroy
```

### Tests (Including Single Test)
Terraform supports native integration tests via `.tftest.hcl` (default directory: `Terraform/tests/`). These create real infrastructure and attempt cleanup.

```bash
# Run all tests
terraform -chdir=Terraform test

# Run a single test file
terraform -chdir=Terraform test -filter tests/my_test.tftest.hcl
```

Optional lint/security tooling (not configured here): `tflint`, `tfsec`, `checkov`. If you add them, also add config files and update this section with exact commands.

### Useful Dev Commands

```bash
# See providers and versions
terraform -chdir=Terraform providers

# Inspect expressions/resources interactively
terraform -chdir=Terraform console

# Create a saved plan you can apply later
terraform -chdir=Terraform plan -input=false -out=tfplan
terraform -chdir=Terraform show -no-color tfplan
terraform -chdir=Terraform apply tfplan
```

## Repo Layout Notes
Terraform only loads `.tf` files in the **current module directory**. Today, code is split across `Terraform/Network/`, `Terraform/Compute/`, etc.

Guidance:
1. Always run `terraform fmt -recursive` so nested `.tf` files get formatted.
1. `terraform -chdir=Terraform validate/plan` only validates the root module under `Terraform/`.
1. If you refactor into modules, add `module` blocks in `Terraform/` so `validate/plan/test` covers everything.

Also:
1. Commit `.terraform.lock.hcl` to keep provider versions stable.
1. Avoid committing `.terraform/` (provider binaries, caches) unless you have a specific reason.

## State / Backends
1. `terraform init -backend=false` is safe for validation and formatting checks.
1. For real deploys, use the project’s chosen backend (S3/DynamoDB, Terraform Cloud, etc.). Don’t change backend configuration without explicit intent.
1. Prefer remote state locking (e.g., DynamoDB) to avoid concurrent apply corruption.

## Environment / Credentials
Terraform AWS provider uses standard auth:

```bash
export AWS_PROFILE=your-profile
export AWS_REGION=ap-south-1
# or AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY / AWS_SESSION_TOKEN
```

Do not hardcode credentials in `.tf` files.

If you need to parameterize regions/AZs:
1. Prefer variables for `region` and look up AZs via `data "aws_availability_zones"` rather than hardcoding.

## Secrets: SOPS Vault Script
`envVault.sh` encrypts/decrypts files between plaintext `.env.local/` (never commit) and encrypted `.env/` (intended to commit):

```bash
./envVault.sh
```

Rules:
1. Never commit plaintext secrets (anything under `.env.local/`).
1. Prefer SOPS-encrypted files in `.env/`, or use AWS SSM/Secrets Manager referenced from Terraform.
1. Treat any in-repo passwords as placeholders; replace with variables and a secure source.

## Terraform Code Style Guidelines

### Formatting / Imports (Terraform “imports”)
1. Use `terraform fmt` (don’t hand-format).
1. Keep blocks ordered within a module: `terraform` / `provider` / `locals` / `data` / `resource` / `module` / `output`.
1. Prefer `locals {}` for derived values and shared tags.

### Naming
1. Use `snake_case` for resource and variable names; be descriptive.
1. Prefer stable keys for `for_each` (e.g., AZ name) over numeric `count` indexes.
1. Tags: include `Name` at minimum and keep tag keys consistent.

### Types / Inputs
1. Always set `type` on variables; add `description` for intent.
1. Use `nullable = false` for required inputs where appropriate.
1. Add `validation` for critical inputs (CIDRs, regions, instance classes, etc.).

Security-related inputs:
1. Mark secrets as `sensitive = true`.
1. Prefer passing secrets via SSM/Secrets Manager references rather than `-var` or plaintext tfvars.

### References / Collections
1. Don’t quote Terraform references: use `aws_security_group.web_sg.id`, not `"aws_security_group.web_sg.id"`.
1. If a resource uses `count`/`for_each`, index it (`[count.index]` or `[each.key]`) everywhere.
1. Prefer `for_each` when identity matters; avoid mixing singleton resources with counted resources unless necessary.

### Error Handling / Safety
1. Avoid destructive flags (e.g., `force_delete = true`) unless explicitly intended.
1. Use `lifecycle { prevent_destroy = true }` for critical, stateful resources when appropriate.
1. Use `create_before_destroy` for replacements to reduce downtime.
1. Prefer dependency edges via references; use `depends_on` only when Terraform can’t infer.

Common pitfalls to avoid (seen frequently in Terraform repos):
1. Don’t pass IDs/names as quoted strings (that breaks dependencies).
1. If a resource uses `count`, remember it becomes a list and must be indexed everywhere.
1. Match resource types exactly (e.g., AWS Elastic IP is `aws_eip`, not `elastic_ip`).
1. Ensure arguments have the expected type (e.g., `availability_zone` is a string; subnets often want a list of subnet IDs).

## Change Checklist (Before PR/Commit)
1. `terraform -chdir=Terraform fmt -recursive`
1. `terraform -chdir=Terraform init -backend=false -input=false`
1. `terraform -chdir=Terraform validate`
1. `terraform -chdir=Terraform plan -input=false` (only if credentials/backends are configured)

### Shell Scripts (Repo Convention)
1. For new scripts, use `set -euo pipefail` and print actionable errors (missing tools, missing keys).
1. Never echo secrets.

## If You Add Tooling
Update this file with exact commands when adding:
1. CI workflows (`.github/workflows/*`)
1. Pre-commit hooks (`.pre-commit-config.yaml`)
1. Lint/security configs (`.tflint.hcl`, `tfsec` config, `checkov` config)
1. Test harness (`Terraform/tests/*.tftest.hcl`, Terratest, etc.)
