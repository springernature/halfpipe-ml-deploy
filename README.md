# halfpipe-ml-deploy

Deploy xquery apps to MarkLogic with [ml-deploy](https://github.com/springernature/ml-deploy).

There are 2 commands for deploying:
  - `/ml-deploy/deploy-local-zip` deploy a local zip file. e.g. one created in a build task
  - `/ml-deploy/deploy-ml-modules` deploy a version of the shared [ml modules library](https://github.com/springernature/ml) from [artifactory](https://springernature.jfrog.io/springernature/simple/libs-release-local/com/springer/ml-modules/)

## Halfpipe examples

### deploying a local zip created in build task
```
tasks:
- type: run
  name: Build
  docker:
    image: alpine
  save_artifacts:
  - target/distribution/my-app.zip
  - target/xquery.zip

- type: run
  name: Deploy to MarkLogic Live
  script: /ml-deploy/deploy-local-zip
  docker:
    image: eu.gcr.io/halfpipe-io/halfpipe-ml-deploy
  restore_artifacts: true
  vars:
    MARKLOGIC_HOST: ml-write.live.sl.i.springer.com
    APP_NAME: my-app
    APP_VERSION: ??? todo ???
    DEPLOY_ZIP: target/xquery.zip

- type: deploy-cf
  name: Deploy to CF Live
  ...
```

### deploying a version of the shared ml modules library from artifactory
```
tasks:
- type: run
  name: Deploy to MarkLogic Live
  script: /ml-deploy/deploy-ml-modules
  docker:
    image: eu.gcr.io/halfpipe-io/halfpipe-ml-deploy
  vars:
    ARTIFACTORY_USER: ((artifactory.username))
    ARTIFACTORY_PASSWORD: ((artifactory.password))
    MARKLOGIC_HOST: ml-write.live.sl.i.springer.com
    APP_NAME: my-app
    APP_VERSION: ??? todo ???
    ML_MODULES_VERSION: "2.1425"
```
