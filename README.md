# 🚀 Production-Ready 3-Tier AWS Architecture (Terraform)

Infrastruttura Cloud resiliente, scalabile e ad alta disponibilità distribuita su AWS utilizzando **Terraform (Infrastructure as Code)**. 

L'architettura segue il pattern classico a **3 livelli (3-Tier)** per garantire la massima sicurezza e la separazione dei compiti (Separation of Concerns).

---

## 📐 Architettura di Rete e Sicurezza

```mermaid
graph TD
    Client[🌐 Internet / Utente] -->|HTTP:80| ALB[⚖️ Application Load Balancer]
    
    subgraph VPC [VPC - 10.0.0.0/16]
        subgraph Public_Subnets [Subnet Pubbliche - 3 AZs]
            ALB
        end

        subgraph App_Subnets [Subnet Private - Application Tier - 3 AZs]
            EC2_A[💻 EC2 Instance - Zone A]
            EC2_B[💻 EC2 Instance - Zone B]
            EC2_C[💻 EC2 Instance - Zone C]
        end

        subgraph DB_Subnets [Subnet Private - Database Tier - 3 AZs]
            RDS[🗄️ PostgreSQL RDS Primary]
        end
    end

    ALB -->|Forward:80| EC2_A
    ALB -->|Forward:80| EC2_B
    ALB -->|Forward:80| EC2_C
    EC2_A -->|PostgreSQL:5432| RDS
    EC2_B -->|PostgreSQL:5432| RDS
    EC2_C -->|PostgreSQL:5432| RDS
```

---

## 🛠️ Stack Tecnologico & Componenti AWS

* **Infrastructure as Code:** Terraform
* **Networking & Load Balancing:** AWS VPC, Internet Gateway, Application Load Balancer (ALB), Public & Private Subnets distribuite su 3 Availability Zones.
* **Compute Tier:** Istanze EC2 distribuite su 3 zone di disponibilità e gestite dietro Application Load Balancer.
* **Database Tier:** Amazon RDS (PostgreSQL) posizionato in subnet private isolate non accessibili dall'esterno.
* **Security:** Security Groups concatenati a cascata (Least Privilege Principle) per consentire solo il traffico strettamente necessario tra i vari livelli.

---

## 🚀 Deployment

1. **Inizializza il provider e i moduli:**
   ```bash
   terraform init
   ```

2. **Verifica il piano di esecuzione:**
   ```bash
   terraform plan
   ```

3. **Applica l'infrastruttura su AWS:**
   ```bash
   terraform apply --auto-approve
   ```

4. **Distruggi le risorse al termine:**
   ```bash
   terraform destroy --auto-approve
   ```