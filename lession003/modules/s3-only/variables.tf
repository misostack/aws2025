variable "bucket_name" {
  type     = string
  nullable = false
}
variable "tags" {
  type    = map(string)
  default = {
    
  }
}

variable "public" {
  type = bool
  default = false
}