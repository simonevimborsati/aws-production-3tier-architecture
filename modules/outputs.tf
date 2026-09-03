# 1. Stampa a terminale l'URL per accedere al Load Balancer
output "alb_dns_name" {
  description = "URL pubblico dell'Application Load Balancer"
  value       = aws_lb.my_alb.dns_name
}

# 2. Stampa a terminale l'Endpoint di connessione al DB
output "db_endpoint" {
  description = "Endpoint di connessione al Database PostgreSQL"
  value       = aws_db_instance.postgres_db.endpoint
}
