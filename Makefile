.PHONEY: all

all: init

.git/git-crypt/keys/default:
	git-crypt unlock ~/.tf_af_keys/tf_af_creds.key

init: .git/git-crypt/keys/default
