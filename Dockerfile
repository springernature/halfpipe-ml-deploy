FROM bash:4.4
RUN apk add --no-cache curl zip
ADD deploy-* /ml-deploy/
