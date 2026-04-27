# AWS Architecture Blueprint: Vocal4Local

## 1. Global & Edge Services
This layer handles incoming user traffic, DNS resolution, and content delivery before requests even hit the core network.
* **Users:** End-users initiate requests.
* **Amazon Route 53:** Acts as the DNS web service, routing users to the application.
* **Amazon CloudFront:** A Content Delivery Network (CDN) that caches data and serves it quickly to users. 
* **AWS WAF (Web Application Firewall):** Protects the application from common web exploits. It sits between CloudFront and the storage layer.
* **Amazon S3:** Stores static assets (like images or frontend files), served securely via WAF and CloudFront.

## 2. Network Foundation
The application resides in the **AWS Mumbai Region** within a highly available, isolated network.
* **VPC (Virtual Private Cloud):** The overarching isolated network boundary.
* **Internet Gateway:** Allows communication between the VPC and the internet.
* **Availability Zones (AZs):** The architecture spans across two distinct physical locations (**Availability Zone 1** and **Availability Zone 2**) to ensure high availability and fault tolerance.

## 3. Traffic Flow & Compute Layer
This is the engine room where the application logic runs and scales based on demand.
* **Application Load Balancer (ALB):** Receives traffic from the Internet Gateway and evenly distributes it across the compute resources in both AZs.
* **Auto Scaling Group:** Manages the deployment of servers, automatically spinning up or terminating instances based on traffic.
* **Amazon EC2 Instances:** The actual virtual servers running the application. These are housed inside a dedicated **Security Group** for firewall protection and are deployed strictly in private subnets.
* **NAT Gateways:** Located in the public subnets, these allow the EC2 instances in the private subnets to securely access the internet (for updates or third-party APIs) without being directly exposed.

## 4. Database Layer
This layer handles data persistence with a focus on redundancy and disaster recovery.
* **Primary Database (SQL):** An Amazon RDS instance residing in the private subnet of AZ 1. It handles all direct read/write requests from the EC2 instances. It is protected by its own **Security Group**.
* **Standby Database:** A replica of the primary database residing in the private subnet of AZ 2. 
* **Synchronous Replication:** Data is continuously and automatically synced from the primary DB to the standby DB to prevent data loss if AZ 1 fails.

## 5. Management & Monitoring
Auxiliary services run alongside the core infrastructure to maintain system health.
* **Amazon CloudWatch / Systems Manager:** (Represented by the pink icons) Used for logging, monitoring system metrics, and managing the operational health of the AWS resources.

---

## Subnet Architecture Breakdown

| Feature | Public Subnets (AZ 1 & 2) | Private Subnets (AZ 1 & 2) |
| :--- | :--- | :--- |
| **Exposure** | Directly accessible from the internet via the Internet Gateway. | Isolated from direct internet access. |
| **Resources Hosted** | NAT Gateways. | EC2 Instances (Auto Scaling Group), RDS Databases. |
| **Security Posture** | Acts as a DMZ (Demilitarized Zone). | Highly secure, strictly controls inbound/outbound rules. |
| **Internet Access** | Native bidirectional access. | Outbound only via NAT Gateway; no inbound access. |
