team: engineering-enablement
pipeline: halfpipe-ml-deploy

triggers:
- type: git
- type: timer
  cron: "0 4 * * FRI"

tasks:
- type: docker-push
  image: eu.gcr.io/halfpipe-io/halfpipe-ml-deploy
