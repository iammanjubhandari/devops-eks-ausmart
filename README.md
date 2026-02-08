# devops-eks-ausmart

# Production Ready Retail Store Microservices Platform on AWS (EKS + Terraform + GitOps)

## Overview
A **production-grade, cloud-native retail e-commerce platform** deployed on **Amazon EKS**, built using Terraform, Kubernetes, Helm, GitHub Actions, GitOps (ArgoCD), autoscaling, and observability

This repository demonstrates **end-to-end DevOps ownership**: from **infrastructure provisioning** to **secure application delivery**, **autoscaling**, **monitoring**, and **GitOps-driven CI/CD** following patterns used in real-world enterprise AWS environments.

⚙️ Built for **reliability, scalability, security, and cost optimisation**.

🎯 Designed to showcase **job-ready DevOps & Cloud Engineering skills** for production teams.

## 🧰 Stack Overview

| Layer                  | Tooling                               |
| ---------------------- | ------------------------------------- |
| Cloud Provider         | AWS                                   |
| Container Runtime      | Docker                                |
| Kubernetes             | Amazon EKS                            |
| Infrastructure as Code | Terraform                             |
| App Packaging          | Helm                                  |
| GitOps CD              | ArgoCD                                |
| CI                     | GitHub Actions                        |
| Autoscaling            | HPA, Karpenter                        |
| Observability          | OpenTelemetry (ADOT), X-Ray, AMP, AMG |
| Secrets                | AWS Secrets Manager, CSI Driver       |
| Networking             | ALB Ingress, External DNS, Route53    |
| Datastores             | RDS (MySQL/Postgres), DynamoDB, Redis |
| Messaging              | Amazon SQS                            |

## 🏗️ Architecture Overview

**Frontend → Microservices → AWS Data Plane → Observability**

- Microservices deployed on EKS
    
- AWS-managed databases and messaging
    
- GitOps-driven deployments
    
- Fully automated DNS, TLS, scaling, and monitoring
    

> This architecture mirrors **production AWS environments**, not local demos.


## 🧩 Microservices

|Service|Language|Backing Service|
|---|---|---|
|UI|Java Spring Boot|—|
|Catalog|Go|Amazon RDS (MySQL)|
|Carts|Java Spring Boot|DynamoDB|
|Orders|Java Spring Boot|Amazon RDS (PostgreSQL)|
|Checkout|Node.js|Redis + Amazon SQS|

All services are:

- Independently deployable
- Containerised
- Helm-managed
- GitOps-controlled


### 🔹 Platform Architecture

- **AWS EKS (Multi-AZ)**
- **Private worker nodes**
- **ALB Ingress Controller**
- **External DNS with Route53**
- **TLS via ACM**
- **GitOps with ArgoCD**

## 🐳 Containerisation

- Multi-stage Docker builds
- BuildKit & buildx (multi-arch: AMD64 / ARM64)
- Image hardening & security best practices
- Docker Compose for local multi-service testing
    
---

## ☸️ Kubernetes Capabilities

- Deployments, Services, StatefulSets
- ConfigMaps & Secrets
- Persistent Volumes (EBS CSI)
- ALB Ingress (HTTP/HTTPS)
- Liveness & readiness probes
- Resource requests & limits
- Namespaces & RBAC


## 🧠 Why This Project Exists

This repository was built to demonstrate:

- **End-to-end ownership** of platform engineering
- **Production decision-making**, not tool demos
- **Cost-aware AWS design** 
- **Modern GitOps workflows**
- **Enterprise observability & scaling patterns**

It aligns closely with **DevOps / Cloud / Platform Engineer roles:

- FinTech
- Government
- Healthcare
- SaaS
- Consulting

## 📚 Reference Project

- Original AWS Sample App  
    [https://github.com/aws-containers/retail-store-sample-app](https://github.com/aws-containers/retail-store-sample-app)

