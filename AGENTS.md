# Agent Instructions (Repo-Specific)

## What This Repo Is
- AWS scalable web architecture implemented as Terraform under `Terraform/`.
- Root module is `Terraform/main.tf`, which composes local modules: `./Network`, `./Security`, `./Compute`, `./Storage`, `./Edge`.

## Commands You Actually Use
```bash
# format everything (includes nested modules)
terraform -chdir=Terraform fmt -recursive

# init in a CI-safe way (no backend prompts)
terraform -chdir=Terraform init -backend=false -input=false

# sanity check wiring
terraform -chdir=Terraform validate

# real plan/apply require AWS creds
terraform -chdir=Terraform plan -input=false
terraform -chdir=Terraform apply
```

## Non-Obvious Terraform Gotchas Here
- Terraform only loads files ending in `.tf` inside each module directory.
- Several module variable files are currently named like `variables.tf.2` / `variables.tf.3` / `variables.tf.4` (Network/Security/Storage), so Terraform ignores them.
- Result: `terraform -chdir=Terraform validate` currently fails with “Unsupported argument” when calling the `database` module from `main.tf`.
- Fix pattern when touching modules: rename any `*.tf.*` to `*.tf` (for example `variables.tf.4` -> `variables.tf`) so module inputs are recognized.

## Module Wiring (Common Failure Mode)
- `main.tf` passes outputs across modules; validate early after changing outputs/variables.
- If you adjust outputs in `Network/outputs.tf`, keep them aligned with what `main.tf` references (currently there are name mismatches like `vpc_vid` vs `vpc_id`, and missing subnet ID list outputs).

## Region / Provider
- AWS provider region is hardcoded to `ap-south-1` in `Terraform/provider.tf`.

## Secrets / Local Env
- `envVault.sh` is a local helper for SOPS; it assumes `sops` is installed and sets `SOPS_AGE_SSH_PRIVATE_KEY_FILE="$HOME/.ssh/github/arch-soul"`.
- Do not commit plaintext secrets from `.env.local/`; only commit encrypted vault outputs if that workflow is being used.
