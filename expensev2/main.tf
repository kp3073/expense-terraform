module "expense" {
  count = 3
  source = "./app-create"
  componant = var.expense[count.index]
}


variable "expense" {
  default = ["frontend","backend","mysql"]
}
