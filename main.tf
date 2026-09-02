module "my_3tier_app" {
  source = "./modules"
  db_password = "var.db_password"
}