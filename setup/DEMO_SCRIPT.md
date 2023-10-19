# Demo Script

1. Go to demo.redhat.com and provision the developer hub and the aws blank environment services
1. Go to the gitlab environment and login with the user1 account
    1. Click on the user profile in the top right
    1. Click on preferences
    1. Click access tokens
    1. Specify a token name
    1. Select all the scopes
    1. Click the "crete personal token button"
    1. Copy the token and use it below for TF_VAR_gitlab_token
1. Run the oc login command you get from the developer hub open shift console for admin account
1. Define a .env file with the following from the output of the demo environments. aws keys from the open aws environment
    ```
    export AWS_ACCESS_KEY_ID=
    export AWS_SECRET_ACCESS_KEY=
    export AWS_REGION=us-east-1
    export TF_VAR_base_domain=$(oc get ingresscontroller/default -n openshift-ingress-operator -o go-template --template="{{.status.domain}}")

    export GITLAB_BASE_URL=https://gitlab-gitlab.apps.$TF_VAR_base_domain/
    export TF_VAR_gitlab_token=
    ```
1. Run `source .env`
1. Run `./setup-env.sh`
1. Run `terraform apply`
1. Follow the script for the developer hub demo
1. Follow this script for skupper overview
    1. run `podman run -p 8080:5050 -d docker.io/vad1mo/hello-world-rest:latest` on laptop
    1. run `oc project skupper2` on laptop
    1. run `skupper init --ingress route --namespace skupper2` on laptop
    1. run `skupper service create laptop 8080` on laptop
    1. run `skupper init --ingress none` on podman vm
    1. run `skupper token create ./skupper2-token` on laptop
    1. run `cat ./skupper2-token | pbcopy` on laptop and copy to clipboard
    1. run `vi ./skupper2-token` on podman vm and copy contents from laptop
    1. run `skupper link create ./skupper2-token` on podman vm
    1. run `skupper service create laptop 8080` on podman vm
    1. run `skupper service bind laptop host 192.168.127.2` on podman vm
    1. show the endpoint now works
1. Follow this script for skupper developer hub automation

## Restart Demo
1. run `./reset-demo.sh`
1. run `terraform destroy`
1. Go to developer hub and remove all the components
1. Go to the argo console and remove all of the bootstrap apps