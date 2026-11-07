module "cloudflare" {
  source = "./modules/cloudflare"

  account_id       = var.account_id
  worker_name      = var.worker_name
  d1_database_name = var.d1_database_name
}

moved {
  from = cloudflare_d1_database.app
  to   = module.cloudflare.cloudflare_d1_database.app
}

moved {
  from = cloudflare_workers_script.hello
  to   = module.cloudflare.cloudflare_workers_script.hello
}

moved {
  from = cloudflare_workers_script_subdomain.hello
  to   = module.cloudflare.cloudflare_workers_script_subdomain.hello
}
