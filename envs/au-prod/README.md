# au-prod — Production Environment

**Status:** Placeholder — not yet deployed  
**Region:** ap-southeast-2 (Sydney)  
**VPC CIDR:** 10.0.0.0/16  

## How to Create

1. Copy all `.tf` files from `envs/au-dev/`
2. Update `terraform.tfvars` with prod values (see Dev vs Prod table in requirements doc)
3. Update `c1-versions.tf` backend to `ausmart-terraform-state-prod`
4. Key changes from dev:
   - `enable_kms = true`
   - `enable_waf = true`
   - `enable_vpc_endpoints = true`
   - `enable_multi_az = true`
   - `single_nat_gateway = false`
   - `rds_deletion_protection = true`
   - `public_access_cidrs = ["YOUR.IP/32"]`
