module "frontend" {
  source = "./app-create"
  componant = "frontend"
}

module "backend" {
  source = "./app-create"
  componant = "backend"
}

module "mysql" {
  source = "./app-create"
  componant = "mysql"
}