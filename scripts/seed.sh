#!/bin/sh

echo '[*] Installing jq...'
apk add jq

echo '[*] Configuring local environment...'
export VAULT_ADDR=http://127.0.0.1:8200

# TODO: Verify we are authed with vault

# Start seeding
echo '[*] Seeding vault...'
if [[ -f /scripts/secrets.json ]]; then
  for path in $(jq -r 'keys[]' < /scripts/secrets.json); do
    echo " -  writing values to ${path}"
    jq ".[\"${path}\"]" /scripts/secrets.json | vault kv put "${path}" -
  done
else
  echo "No secrets.json file found... skipping."
fi
