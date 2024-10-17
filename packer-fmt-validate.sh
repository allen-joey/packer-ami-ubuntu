#!/bin/bash

# set -x
# set -e

# Packer format
echo "Packer format check…"
packer fmt .

# Packer validate
echo "Packer validate check…"
packer validate .

exit 0
