FROM debian:stable-slim
RUN apt-get update && apt-get install -y \
    curl \
    zip
ADD deploy-* /ml-deploy/
