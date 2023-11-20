#!/usr/bin/env -S just --justfile
# ^ A shebang isn't required, but allows a justfile to be executed
#   like a script, with `./justfile test`, for example.

alias c := create
alias d := delete

create: delete
	kind create cluster --name=host-cluster --config=config.yaml

delete:
    kind delete cluster --name=host-cluster

ingress:
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml