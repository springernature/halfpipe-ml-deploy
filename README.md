# halfpipe-ml-deploy

Deploy xquery apps to MarkLogic with [ml-deploy](https://github.com/springernature/ml-deploy).

There are 2 commands for deploying:
  - `/ml-deploy/deploy-local-zip` deploy a local zip file. e.g. one created in a build task
  - `/ml-deploy/deploy-ml-modules` deploy a version of the shared [ml modules library](https://github.com/springernature/ml) from [artifactory](https://springernature.jfrog.io/springernature/simple/libs-release-local/com/springer/ml-modules/)

All arguments are passed as environment variables.

`APP_VERSION` is optional. By default it is set to the current git revision. So apps should reach them like this: `http://{MARKLOGIC_HOST}:7655/{APP_NAME}/{GIT_REVISION}/some/endpoint.xqy`

It is possible to deploy to more than one `MARKLOGIC_HOST` by providing a comma separated list of hostnames.

## Halfpipe examples

### deploying a local zip created in build task
```yml
tasks:
- type: run
  name: Deploy to MarkLogic Live
  script: /ml-deploy/deploy-local-zip
  docker:
    image: eu.gcr.io/halfpipe-io/halfpipe-ml-deploy
  restore_artifacts: true
  vars:
    MARKLOGIC_HOST: ml-write.live.sl.i.springer.com
    APP_NAME: my-app
    APP_VERSION: v1        # OPTIONAL defaults to $GIT_REVISION
    DEPLOY_ZIP: target/xquery.zip
  ...
```

### deploying a version of the shared ml modules library from artifactory to 2 MarkLogic hosts
```yml
tasks:
- type: run
  name: Deploy to MarkLogic Live
  script: /ml-deploy/deploy-ml-modules
  docker:
    image: eu.gcr.io/halfpipe-io/halfpipe-ml-deploy
  vars:
    ARTIFACTORY_USER: ((artifactory.username))
    ARTIFACTORY_PASSWORD: ((artifactory.password))
    MARKLOGIC_HOST: ml.dev.springer-sbm.com,ml.qa1.springer-sbm.com
    APP_NAME: my-app
    APP_VERSION: v1        # OPTIONAL defaults to $GIT_REVISION
    ML_MODULES_VERSION: "2.1425"
```
