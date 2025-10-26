# goodnote-homework



### 1. For each pull request to the default branch, trigger the CI workflow. (for example with GitHub Actions)

In currently implementation, this workflow run CI when it's a 'Ready'( to review) pull request rather than a 'Draft' one.

'main'  was assumed as the dafault branch name in our branch naming convention.

Pull Request with changes to README or test case only was ingored.

Optional: workflow_dispatch was enabled, so we can send http request to trigger this workflow. 

##### References
[1.a Workflow syntax](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax)

[1.b Trigger Events](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax)

[1.c github context](https://docs.github.com/en/actions/reference/workflows-and-actions/contexts?versionId=free-pro-team%40latest&productId=actions&restPage=reference%2Cworkflows-and-actions%2Cevents-that-trigger-workflows#github-context)

### 2.Provision a multi-node (at least 2 nodes) Kubernetes cluster (you may use KinD to provision this cluster on the CI runner (localhost))

```kind create cluster --name k8s-playground --config task2-kind-k8s-cluster.yml```

##### Reference
[2.a nodes](https://kind.sigs.k8s.io/docs/user/configuration/#nodes)

[2.b version](https://kind.sigs.k8s.io/docs/user/configuration/#kubernetes-version)

### 3.Deploy Ingress controller to handle incoming HTTP requests

```kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml```
Since need to use NodePort Type service for ingress controller in local lab, need update spec of ingress-nginx-controller service

##### References
[3.a ingress-nginx](https://github.com/kubernetes/ingress-nginx)

[3.b Ingress-Nginx Controller](https://kubernetes.github.io/ingress-nginx/)