.PHONEY: all

all: init

.git/git-crypt:
	git-crypt unlock ~/.tf_af_keys/tf_af_creds.key

init: .git/git-crypt
