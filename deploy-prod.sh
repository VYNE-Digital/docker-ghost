#!/bin/bash

if [[ $# != 1 ]]
then
  echo 'This script takes exactly 1 argument'
  echo 'Usage: ./deploy $ENV_FILE_PATH'
  exit 1
fi

ENV_FILE=$1

if [[ ! -f $ENV_FILE ]]
then
	echo "EXITING: $ENV_FILE not found!"
  exit 1
fi

# Loading environment variables
echo "Sourcing $ENV_FILE"
source $ENV_FILE

echo "Deploying Ghost with the following configuration:"
echo "Blog URL: $BLOG_URL"
echo "Ghost host data folder: $GHOST_HOST_PATH"
echo "HTTP port: $NGINX_HTTP_PORT"
echo "HTTPS port: $NGINX_HTTPS_PORT"

read -p "Confirm the deployment? (Y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  echo "ABORTING..."
  exit 1
fi

echo "Deploying..."
pushd blog/ > /dev/null
docker compose up -f blog/docker-compose.yaml -d
