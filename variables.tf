variable "access_key" {
  description = "Access Key of the aws "
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "Secret Key of the AWS "
  type        = string
  sensitive   = true
}

variable "zone_id" {
    description = "Zone ID for SES"
    type = string
}

variable "ses_name"{
    description = "record name"
    type = string
}

variable "record_type"{
    description = "record type"
    type = string
    default = "TXT"
}

variable "ses_ttl"{
    description = "TTL"
    type = string
    default = "600"
}

