team: engineering-enablement
pipeline: halfpipe-ml-deploy

tasks:
# - type: docker-push
#   image: eu.gcr.io/halfpipe-io/halfpipe-ml-deploy

- type: run
  script: /sssssssss
  docker:
    image: eu.gcr.io/halfpipe-io/halfpipe-ml-deploy
  save_artifacts: [ . ]

- type: run
  name: Deploy ml-modules artifact
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
