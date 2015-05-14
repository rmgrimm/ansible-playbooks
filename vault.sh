#!/bin/bash

if ! which ansible-vault >/dev/null ; then
    echo Ansible not on PATH; exiting...
    exit 1
fi

if [ $# -lt 2 ]; then
    echo "Usage: $0 <ansible-vault commands> [options] <filename>"
    exit 1
fi

ANSIBLE_VAULT_OPT="$(dirname $0)/vault-pass.txt"
if [ -f "$ANSIBLE_VAULT_OPT" ]; then
    ANSIBLE_VAULT_OPT="--vault-password-file=$ANSIBLE_VAULT_OPT"
else
    echo "Warning: $ANSIBLE_VAULT_OPT not found; not setting vault-pass-file option..."
    ANSIBLE_VAULT_OPT=
fi

ansible-vault $ANSIBLE_VAULT_OPT "$@"
