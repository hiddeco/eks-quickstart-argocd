# EKS Quickstart ArgoCD

This repository contains an experimental set of cluster components to be
installed and configured by [eksctl](https://github.com/weaveworks/eksctl).

It provides a quickstart profile for cluster operators to declaratively
manage ArgoCD configuration and `AppProject` / `Application` resources.
These resources are applied by [Flux](https://github.com/fluxcd/flux),
providing a non-application centric configuration for core cluster
components, simpler [app of apps
patterns](https://argoproj.github.io/argo-cd/operator-manual/declarative-setup/#app-of-apps),
and easier bootstrapping of the ArgoCD environment.

## Components

- [ArgoCD](https://argoproj.github.io/argo-cd/operator-manual/architecture/)
  &mdash; To manage _applications_ in a GitOps manner.
- Demo &mdash; A demo `AppProject` and guestbook `Application`

## Install

Create an EKS cluster in your preferred region:

```sh
eksctl create \
--name=<name> \
--region=<region> \
--nodes 2 \
--node-volume-size=120
```

The above command will create a two node EKS cluster.

Create a repository on GitHub and run the `enable repo` and `enable
profile` commands (replace `GHUSER` and `GHREPO` values with your own):

```sh
export GHUSER=username
export GHREPO=repo
export EKSCTL_EXPERIMENTAL=true

eksctl enable repo \
--cluster=<name> \
--region=<region> \
--git-url=git@github.com:${GHUSER}/${GHREPO} \
--git-user=fluxcd \
--git-email=${GHUSER}@users.noreply.github.com
```

The command `eksctl enable repo` takes an existing EKS cluster and
an empty repository and sets up a GitOps pipeline.

```sh
eksctl enable profile \
--cluster=<name> \
--region=<region> \
--git-url=git@github.com:${GHUSER}/${GHREPO} \
--git-user=fluxcd \
--git-email=${GHUSER}@users.noreply.github.com \
git@github.com:hiddeco/eks-quickstart-argocd
```

The command `eksctl enable profile` installs the ArgoCD on this
cluster, and adds its manifests to the configured repository.

List the installed ArgoCD Helm chart:

```console
$ kubectl get hr -A
NAMESPACE   NAME     RELEASE   PHASE       STATUS     MESSAGE
                        AGE
argocd      argocd   argocd    Succeeded   deployed   Release was successful for Helm release
'argocd' in 'argocd'.   8m30s
```

List the installed `Application` resources:

```console
$ kubectl get applications -n argocd
NAME        AGE
guestbook   4m8s
```

Access the (read-only) ArgoCD dashboard with:

```sh
kubectl -n argocd port-forward service/argocd-server 8080:8080
```

Open your browser and navigate to `localhost:8080` (accepting the
self-signed certificate).
