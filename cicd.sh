#!/bin/bash
set -e

DOCKER_USERNAME="realism1"
IMAGE_NAME="webserver"
IMAGE_TAG="latest"
HELM_RELEASE_NAME="webserver"
HELM_CHART_PATH="./helm-chart"
DOCKER_IMAGE="$DOCKER_USERNAME/$IMAGE_NAME:$IMAGE_TAG"

docker build -t $DOCKER_IMAGE .

docker login

docker push $DOCKER_IMAGE

helm upgrade --install $HELM_RELEASE_NAME $HELM_CHART_PATH \
  --set image.repository=$DOCKER_USERNAME/$IMAGE_NAME \
  --set image.tag=$IMAGE_TAG
