variable "yc_service_account_key_file" {
  description = "Путь к JSON‑ключу сервисного аккаунта (например, ./sa-key.json)"
  type        = string
}

variable "cloud_id" {
  description = "Идентификатор облака"
  type        = string
}

variable "folder_id" {
  description = "Идентификатор каталога"
  type        = string
}

variable "service_account_id" {
  description = "Идентификатор сервисного аккаунта"
  type        = string
}

variable "zone" {
  description = "Зона доступности (например, ru-central1-a)"
  type        = string
  default     = "ru-central1-a"
}