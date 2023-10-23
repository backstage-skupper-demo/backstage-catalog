#!/bin/bash

chmod 0600 ./private_key
ssh ec2-user@$(cat ./vm_ip) -i ./private_key