This is a docker set that builds a consul container, a vault container (that uses consul for backend storage), and a vault-ui container. This is only for development purposes. There is no security configured and this is NOT for use in any production environment.

**All example command MUST be run in the root directory of the repo.**

# Installation

* Clone the repo

```
git clone https://github.com/zanloy/docker-vault.git
```

* Bring up the containers

Using Rake: `rake up`

Using Bash: `sudo docker-compose up`

* Initialize Vault (Only needs to be run the first time)

Using Rake: `rake setup`

Using Bash: `sudo docker-compose exec vault /scripts/setup.sh`

* Unseal Vault (This step is done during setup so only needed after first run)

Using Rake: `rake unseal`

Using Bash: `sudo docker-compose exec vault /scripts/unseal.sh`

* Seed Vault with data (Optional)

You will need to create a file /scripts/secrets.json with your data. Below is an example:

```
{
  "secret/login-info": {
    "username": "root",
    "password": "p@ssw0rd"
  }
}
```

Using Rake: `rake seed`

Using Bash: `sudo docker-compose exec vault /scripts/seal.sh`

* Destroy containers (data is persistant)

Using Rake: `rake down`

Using Bash: `sudo docker-compose down`

# Other Tasks

* Clean all data

All data is persistant across reboots so if you want to clean up consul and vault then run the following.

Using Rake: `rake clean`

Using Bash: `sudo scripts/clean.sh`

# TODO:
* Clean up data/keys.txt and make it easier to read programmatically. eg: convert to json
