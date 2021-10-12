#!/bin/bash
# Author: Kamil Halat <kh@euro-linux.com> 

ansible-galaxy install -r requirements.yml

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

declare -A collections=(
    ["https://github.com/CiscoDevNet/ansible-aci"]="v2.1.0"
    ["https://github.com/CiscoDevNet/ansible-nae"]="4883596"
    ["https://github.com/CiscoDevNet/ansible-mso"]="c7f9f19"
)

for collection in ${!collections[@]}; do
    git clone "$collection.git"
    cd ${collection##*/}
    git checkout ${collections[$collection]}
    ansible-galaxy collection build --force
    ansible-galaxy collection install *.tar.gz --force
    cd $SCRIPT_DIR
done
