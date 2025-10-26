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