#!/bin/bash

# set -x
# set -e

# Packer build
echo "Packer Build with Force…"
packer build -force .

exit 0