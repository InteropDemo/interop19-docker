#!/bin/bash
/usr/bin/docker exec -it ansible /usr/bin/bash -c "ansible-playbook interop.yml -i ntc-hosts"
