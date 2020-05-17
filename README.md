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
