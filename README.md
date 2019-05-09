# halfpipe-ml-deploy

Deploy xquery apps to MarkLogic with [ml-deploy](https://github.com/springernature/ml-deploy).

There are 2 commands for deploying:
  - `/ml-deploy/deploy-local-zip` deploy a local zip file. e.g. one created in a build task
  - `/ml-deploy/deploy-ml-modules` deploy a version of the shared [ml modules library](https://github.com/springernature/ml) from [artifactory](https://springernature.jfrog.io/springernature/simple/libs-release-local/com/springer/ml-modules/)

All arguments are passed as environment variables.

`APP_VERSION` is optional. By default it is set to the current git revision. So apps should reach them like this: `http://{MARKLOGIC_HOST}:7655/{APP_NAME}/{GIT_REVISION}/some/endpoint.xqy`

Setting `USE_BUILD_VERSION: true` will use the environment variable `BUILD_VERSION` instead of `GIT_REVISION`.

It is possible to deploy to more than one `MARKLOGIC_HOST` by providing a comma separated list of hostnames.

## Halfpipe examples

There are halfpipe task types for the 2 commands:

### deploying a local zip created in build task
```yml
tasks:
- type: deploy-ml-zip
  deploy_zip: target/xquery.zip
  app_name: example-app       # optional. defaults to pipeline name
  app_version: v1             # optional. defaults to GIT_REVISION
  use_build_version: true     # optional. Use BUILD_VERSION instead of GIT_REVISION. defaults to false
  targets:
  - ml.dev.springer-sbm.com
  ...
```

### deploying a version of the shared ml modules library from artifactory to 2 MarkLogic hosts
```yml
tasks:
- type: deploy-ml-modules
  name: Deploy XQuery to Dev and QA
  ml_modules_version: "2.1428"
  app_name: halfpipe-example  # optional. defaults to pipeline name
  app_version: v1             # optional. defaults to GIT_REVISION
  use_build_version: true     # optional. Use BUILD_VERSION instead of GIT_REVISION. defaults to false
  targets:
  - ml.dev.springer-sbm.com
  - ml.qa1.springer-sbm.com
```
