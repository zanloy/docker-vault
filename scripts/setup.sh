#!/bin/sh

# Config
echo "[*] Configuring local environment..."
export VAULT_ADDR=http://127.0.0.1:8200

# Init Vault
echo "[*] Initializing vault..."
if [[ ! -f /data/keys.txt ]]; then
  vault operator init -key-shares=1 -key-threshold=1 > /data/keys.txt
else
  echo ' -  keys.txt file already exists... skipping'
fi

export _VAULT_KEY=$(grep 'Unseal Key 1:' /data/keys.txt | awk '{print $NF}')
export _VAULT_TOKEN=$(grep 'Initial Root Token:' /data/keys.txt | awk '{print $NF}')

### DEBUG ###
#echo "_VAULT_KEY = ${_VAULT_KEY}"
#echo "_VAULT_TOKEN = ${_VAULT_TOKEN}"
#############

# Unseal Vault
echo "[*] Unsealing vault..."
vault operator unseal ${_VAULT_KEY}

# Auth
echo "[*] Authenticating with Vault..."
vault login ${_VAULT_TOKEN}

# Create webui user
echo "[*] Creating user..."
vault auth enable userpass
vault policy write admin /config/admin.hcl
vault write auth/userpass/users/webui password=webui policies=admin

# Create backup token
echo "[*] Creating backup token..."
vault token create -display-name="backup_token" | awk '/token/{i++}i==2' | awk '{print "backup_token: " $2}' >> /data/keys.txt

# Mounts
echo "[*] Mounting kv secret engine at /secret..."
vault secrets enable -path=secret kv

## Read/Write
# vault kv put secret/api-key key=value
# vault kv get secret/api-key
