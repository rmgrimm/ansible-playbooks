#!/bin/bash

if ! which ansible-playbook >/dev/null ; then
    echo Ansible not on PATH; exiting...
    exit 1
fi

if [ $# -lt 2 ]; then
    echo "Usage: $0 <inventory> <playbook> [ansible-playbook options...]"
    exit 1
fi

ANSIBLE_INVENTORY="$(dirname $0)/inventory/$1"
if [ ! -f "$ANSIBLE_INVENTORY" ]; then
    echo "Inventory $ANSIBLE_INVENTORY not found; exiting..."
    exit 1
fi

ANSIBLE_VAULT_OPT="$(dirname $0)/vault-pass.txt"
if [ -f "$ANSIBLE_VAULT_OPT" ]; then
    ANSIBLE_VAULT_OPT="--vault-password-file=$ANSIBLE_VAULT_OPT"
else
    echo "Warning: $ANSIBLE_VAULT_OPT not found; not setting vault-pass-file option..."
    ANSIBLE_VAULT_OPT=
fi

shift

ansible-playbook -i "$ANSIBLE_INVENTORY" "$@" $ANSIBLE_VAULT_OPT --ask-become-pass
