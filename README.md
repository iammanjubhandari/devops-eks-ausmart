# devops-eks-ausmart

Production-ready retail store microservices platform on AWS EKS, built with Terraform, Kubernetes, Helm, and GitOps.

## Overview

Cloud-native retail e-commerce platform deployed on Amazon EKS. Covers end-to-end DevOps ownership: infrastructure provisioning, secure application delivery, autoscaling, monitoring, and GitOps-driven CI/CD.

Built for reliability, scalability, security, and cost optimisation — following patterns used in real-world enterprise AWS environments.

## Stack

| Layer | Tooling |
| ----- | ------- |
| Cloud Provider | AWS |
| Container Runtime | Docker |
| Kubernetes | Amazon EKS |
| Infrastructure as Code | Terraform |
| App Packaging | Helm |
| GitOps CD | ArgoCD |
| CI | GitHub Actions |
| Autoscaling | HPA, Karpenter |
| Observability | OpenTelemetry (ADOT), X-Ray, AMP, AMG |
| Secrets | AWS Secrets Manager, CSI Driver |
| Networking | ALB Ingress, External DNS, Route53 |
| Datastores | RDS (MySQL/Postgres), DynamoDB, Redis |
| Messaging | Amazon SQS |

## Microservices

| Service | Language | Backing Service |
| ------- | -------- | --------------- |
| UI | Java Spring Boot | — |
| Catalog | Go | Amazon RDS (MySQL) |
| Carts | Java Spring Boot | DynamoDB |
| Orders | Java Spring Boot | Amazon RDS (PostgreSQL) |
| Checkout | Node.js | Redis + Amazon SQS |

All services are independently deployable, containerised, Helm-managed, and GitOps-controlled.

## Platform Architecture

- AWS EKS (Multi-AZ) with private worker nodes
- ALB Ingress Controller + External DNS with Route53
- TLS via ACM
- GitOps with ArgoCD
- Karpenter for node autoscaling, HPA for pod autoscaling

## Containerisation

- Multi-stage Docker builds
- BuildKit & buildx (multi-arch: AMD64 / ARM64)
- Image hardening (non-root user, minimal base images)
- Docker Compose for local multi-service testing

## Kubernetes Capabilities

- Deployments, Services, StatefulSets
- ConfigMaps & Secrets (via Secrets Store CSI)
- Persistent Volumes (EBS CSI)
- ALB Ingress (HTTP/HTTPS)
- Liveness & readiness probes
- Resource requests & limits
- NetworkPolicies for pod-to-pod isolation
- Namespaces & RBAC

## Project Structure

```text
modules/          # Reusable Terraform modules (VPC, EKS, KMS, etc.)
envs/             # Per-environment configs (au-dev, au-prod, us-prod)
kubernetes/       # K8s manifests and Helm charts
autoscaling/      # HPA and Karpenter configs
cicd/             # GitHub Actions + ArgoCD
observability/    # ADOT collectors for traces, logs, metrics
```

## Why this project exists

Built to demonstrate end-to-end platform engineering ownership — not just tool demos. Every decision (single NAT in dev, Karpenter over Cluster Autoscaler, Pod Identity over IRSA) is documented with reasoning.

Targets DevOps / Cloud / Platform Engineer roles in FinTech, Government, Healthcare, SaaS, and Consulting.

## Reference

Original AWS Sample App: [retail-store-sample-app](https://github.com/aws-containers/retail-store-sample-app)
