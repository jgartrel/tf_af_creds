Anchorfree credentials terraform module
===========

A terraform module to provide shared credentials used by devops.  This should be used for bootstrapping independent services.


External Dependencies
---------------------

This module requires git-crypt to be installed on your machine. See [Installing git-crypt](https://github.com/AGWA/git-crypt/blob/master/INSTALL.md) for more information, or if you are running on a Mac, just run:
```
brew install git-crypt
```


Module Input Variables
----------------------

- (None)


Usage
-----

```hcl
module "creds" {
  source = "git::ssh://git@github.com/AnchorFree/tf_af_creds.git"
}

provider "digitalocean" {
  token = "${module.creds.do_token}"
}

```

To use this repo you will need to add a key to:
1. Create a keys directory: `mkdir -p -m 700 ~/.tf_af_keys`
2. Copy the following key from Ilya; put them into the key dir (mode 0600)
  * `~/.tf_af_keys/tf_af_creds.key`

You should also add the following recipe to the `make init` goal in your project's Makefile:
```Makefile
.PHONEY: all init

all: init

TF_FILES=$(wildcard *.tf)

.terraform/modules.done: $(TF_FILES)
	terraform get --update
	@for i in $$(ls .terraform/modules/*/Makefile); \
	do \
		i=$$(dirname $$i); \
		echo "Trying make in $$i"; \
		$(MAKE) -C $$i; \
	done
	touch .terraform/modules.done

init: .terraform/modules.done
```


Outputs
-------

- `do_token` - Token to be consumed by the DigitalOcean Provider
- `do_priv_key` - A private key to be used for initial login to the host
- `do_pub_key` - The public key associated with do_priv_key
- `do_ssh_fingerprint` - The fingerprint of the do_pub_key
- `do_key_name` - The friendly name of the ssh key
