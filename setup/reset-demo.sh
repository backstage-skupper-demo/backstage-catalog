#!/bin/bash

glab project delete development/my-quarkus-app-gitops -y
glab project delete development/my-quarkus-app -y
glab project delete development/skupper -y
glab project delete development/skuppervm -y
skupper delete --namespace skupper2

chmod 0600 ./private_key
ssh ec2-user@$(cat ./vm_ip) -i ./private_key skupper delete