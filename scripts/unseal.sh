#!/bin/sh

# Config
echo "[*] Configuring local environment..."
_VAULT_KEY=$(grep 'Unseal Key 1:' /data/keys.txt | awk '{print $NF}')

## UNSEAL VAULT
echo "[*] Unsealing vault..."
vault operator unseal ${_VAULT_KEY}
