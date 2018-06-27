FROM bash:4.4
RUN apk add --no-cache curl
ADD deploy-* /ml-deploy/
