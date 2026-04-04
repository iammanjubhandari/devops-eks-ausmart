# us-prod — US DR/Active Region

**Status:** Placeholder — Phase 10  
**Region:** us-west-2 (Oregon)  
**VPC CIDR:** 10.1.0.0/16 (non-overlapping with AU)  

## How to Create

1. Copy all `.tf` files from `envs/au-prod/`
2. Update `terraform.tfvars`: region, CIDR, cluster name
3. Create S3 state bucket in us-west-2
4. `terraform init && terraform apply`

See `docs/MULTI-REGION-AND-DATA-SOVEREIGNTY.md` for full strategy.
