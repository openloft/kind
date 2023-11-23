#!/usr/bin/env -S just --justfile
# ^ A shebang isn't required, but allows a justfile to be executed
#   like a script, with `./justfile test`, for example.

alias a := all
alias c := create
alias d := delete

create: delete
    kind create cluster --name=host-cluster --config=config.yaml

delete:
    kind delete cluster --name=host-cluster

ingress:
    wget -O ingress-nginx.yaml https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml
    sed -i "" -E 's#- /nginx-ingress-controller#- /nginx-ingress-controller\n        - --enable-ssl-passthrough#g' ingress-nginx.yaml
    kubectl apply -f ingress-nginx.yaml

nvgpu:
    kubectl apply -f nvgpu.yaml

all: create ingress nvgpu