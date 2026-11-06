variable "account_id" {
  description = "Identificador de la cuenta de Cloudflare"
  type        = string
}

variable "api_token" {
  description = "Token de API con permisos para Workers y D1"
  type        = string
  sensitive   = true
}

variable "worker_name" {
  description = "Nombre nuevo y único del Worker para esta práctica"
  type        = string
}

variable "d1_database_name" {
  description = "Nombre nuevo y único de la base de datos D1 de prueba"
  type        = string
}
