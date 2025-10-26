# goodnote-homework




## Summary
A. Unexpacted time was spent to setup the local lab enviroment and troubeshooting

B. Since 18:30 until 22:30.  4 Hours was used to get these and some verification

C. Idealy we should can check the load perf graphs as example of [Report_Graphing.png](./Report_Graphing.png)

D. Still not everything was fully ready tested so far.

     D1 Cluster provisioning and load test enviroment preparation is not part of workflow yet, 

     D2 Tunning script and workflow while trigger it again and again.



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



### 4.Create 2 http-echo deployments, one serving a response of “bar” and another serving a response of “foo”.

TLTR



### 5.Configure cluster / ingress routing to send traffic for “bar” hostname to the bar deployment and “foo” hostname to the foo deployment on local cluster (i.e. route both http://foo.localhost and http://bar.localhost).
TLTR



### 6.Ensure the ingress and deployments are healthy before proceeding to the next step.
```kubectl -n foobar get pod```
```kubectl -n ingress-nginx logs -f ingress-nginx-controller-86bb9f8d4b-4dw6p```



### 7.Generate a load of randomized traffic for bar and foo hosts and capture the load testing result

[fortio load testing](https://github.com/fortio/fortio)



### 8.Post the output of the load testing result as comment on the GitHub Pull Request 

[createComment](https://github.com/actions/github-script)




## Sample Load Test Report Format ##
```
21:26:04.635 r1 [INF] scli.go:124> Starting, command="Φορτίο", version="1.73.0 h1:ZQU9uuzn7bF5Fvk3G/qyTQoRUUYdMLOWPsUr0RRhQ3k= go1.25.2 arm64 darwin", go-max-procs=10
Fortio 1.73.0 running at 5000 queries per second, 10->10 procs, for 1m0s: http://captive.apple.com/
21:26:04.636 r1 [INF] httprunner.go:121> Starting http test, run=0, url="http://captive.apple.com/", threads=8, qps="5000.0", warmup="parallel", conn-reuse=""
Starting at 5000 qps with 8 thread(s) [gomax 10] for 1m0s : 37500 calls each (total 300000)
21:27:04.880 r115 [WRN] periodic.go:813> T001 warning only did 670 out of 37500 calls before reaching 1m0s
21:27:04.880 r115 [INF] periodic.go:882> T001 ended after 1m0.020055833s : 670 calls. qps=11.162935300563701
21:27:04.891 r119 [WRN] periodic.go:813> T005 warning only did 661 out of 37500 calls before reaching 1m0s
21:27:04.891 r119 [INF] periodic.go:882> T005 ended after 1m0.030891333s : 661 calls. qps=11.010997593444644
21:27:04.894 r116 [WRN] periodic.go:813> T002 warning only did 637 out of 37500 calls before reaching 1m0s
21:27:04.894 r116 [INF] periodic.go:882> T002 ended after 1m0.033966417s : 637 calls. qps=10.610659898354122
21:27:04.898 r118 [WRN] periodic.go:813> T004 warning only did 661 out of 37500 calls before reaching 1m0s
21:27:04.898 r118 [INF] periodic.go:882> T004 ended after 1m0.037622417s : 661 calls. qps=11.009763101691949
21:27:04.902 r121 [WRN] periodic.go:813> T007 warning only did 728 out of 37500 calls before reaching 1m0s
21:27:04.902 r121 [INF] periodic.go:882> T007 ended after 1m0.042125917s : 728 calls. qps=12.124820513623387
21:27:04.903 r120 [WRN] periodic.go:813> T006 warning only did 688 out of 37500 calls before reaching 1m0s
21:27:04.903 r120 [INF] periodic.go:882> T006 ended after 1m0.043501208s : 688 calls. qps=11.458359125605638
21:27:04.925 r114 [WRN] periodic.go:813> T000 warning only did 400 out of 37500 calls before reaching 1m0s
21:27:04.925 r114 [INF] periodic.go:882> T000 ended after 1m0.065380917s : 400 calls. qps=6.659410027761766
21:27:04.985 r117 [WRN] periodic.go:813> T003 warning only did 407 out of 37500 calls before reaching 1m0s
21:27:04.985 r117 [INF] periodic.go:882> T003 ended after 1m0.124601958s : 407 calls. qps=6.769275583467639
Ended after 1m0.125224875s : 4852 calls. qps=80.698
21:27:04.986 r1 [INF] periodic.go:598> Run ended, run=0, elapsed=60125224875, calls=4852, qps=80.69824287705003
Aggregated Sleep Time : count 4852 avg -30.25036 +/- 17.2 min -59.473337468 max -0.075178291 sum -146774.745
# range, mid point, percentile, count
>= -59.4733 <= -0.0751783 , -29.7743 , 100.00, 4852
# target 50% -29.7804
WARNING 100.00% of sleep were falling behind
Aggregated Function Time : count 4852 avg 0.098997222 +/- 0.08556 min 0.067214458 max 2.835409666 sum 480.334522
# range, mid point, percentile, count
>= 0.0672145 <= 0.07 , 0.0686072 , 18.40, 893
> 0.07 <= 0.08 , 0.075 , 74.96, 2744
> 0.08 <= 0.09 , 0.085 , 79.39, 215
> 0.09 <= 0.1 , 0.095 , 80.42, 50
> 0.1 <= 0.2 , 0.15 , 94.54, 685
> 0.3 <= 0.4 , 0.35 , 98.80, 207
> 0.4 <= 0.5 , 0.45 , 99.42, 30
> 0.5 <= 0.75 , 0.625 , 99.94, 25
> 0.75 <= 1 , 0.875 , 99.96, 1
> 1 <= 2 , 1.5 , 99.98, 1
> 2 <= 2.83541 , 2.4177 , 100.00, 1
# target 50% 0.0755867
# target 75% 0.080093
# target 90% 0.167854
# target 99% 0.4316
# target 99.9% 0.73148
Error cases : no data
# Socket and IP used for each connection:
[0]   1 socket used, resolved to 17.253.118.201:80, connection timing : count 1 avg 0.10838175 +/- 0 min 0.10838175 max 0.10838175 sum 0.10838175
[1]   1 socket used, resolved to 17.253.118.202:80, connection timing : count 1 avg 0.069094916 +/- 0 min 0.069094916 max 0.069094916 sum 0.069094916
[2]   1 socket used, resolved to 17.253.118.201:80, connection timing : count 1 avg 0.072135459 +/- 0 min 0.072135459 max 0.072135459 sum 0.072135459
[3]   1 socket used, resolved to 17.253.118.202:80, connection timing : count 1 avg 0.10608883 +/- 0 min 0.106088833 max 0.106088833 sum 0.106088833
[4]   1 socket used, resolved to 17.253.118.201:80, connection timing : count 1 avg 0.078939958 +/- 0 min 0.078939958 max 0.078939958 sum 0.078939958
[5]   1 socket used, resolved to 17.253.118.202:80, connection timing : count 1 avg 0.078916916 +/- 0 min 0.078916916 max 0.078916916 sum 0.078916916
[6]   1 socket used, resolved to 17.253.118.201:80, connection timing : count 1 avg 0.071601125 +/- 0 min 0.071601125 max 0.071601125 sum 0.071601125
[7]   1 socket used, resolved to 17.253.118.202:80, connection timing : count 1 avg 0.069180958 +/- 0 min 0.069180958 max 0.069180958 sum 0.069180958
Connection time histogram (s) : count 8 avg 0.081792489 +/- 0.01513 min 0.069094916 max 0.10838175 sum 0.654339915
# range, mid point, percentile, count
>= 0.0690949 <= 0.07 , 0.0695475 , 25.00, 2
> 0.07 <= 0.08 , 0.075 , 75.00, 4
> 0.1 <= 0.108382 , 0.104191 , 100.00, 2
# target 50% 0.075
# target 75% 0.08
# target 90% 0.105029
# target 99% 0.108046
# target 99.9% 0.108348
Sockets used: 8 (for perfect keepalive, would be 8)
Uniform: false, Jitter: false, Catchup allowed: true
IP addresses distribution:
17.253.118.201:80: 4
17.253.118.202:80: 4
Code 200 : 4852 (100.0 %)
Response Header Sizes : count 4852 avg 456.91756 +/- 0.275 min 456 max 457 sum 2216964
Response Body/Total Sizes : count 4852 avg 525.91756 +/- 0.275 min 525 max 526 sum 2551752
All done 4852 calls (plus 8 warmup) 98.997 ms avg, 80.7 qps
```