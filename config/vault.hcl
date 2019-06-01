backend "consul" {
  address        = "consul:8500"
  advertise_addr = "http://consul:8300"
  scheme         = "http"
  path           = "vault"
}

#storage "file" {
#  path = "/vault/file"
#}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = true
}

disable_mlock = true
