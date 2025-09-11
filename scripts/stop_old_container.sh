#!/bin/bash
# 이전 Docker 컨테이너 중지 및 삭제
echo "Stopping and removing existing Docker container..."

# 이전에 실행 중인 컨테이너가 있다면 중지
if [ "$(sudo docker ps -q -f name=my-app-container)" ]; then
  echo "Existing container found. Stopping..."
  sudo docker stop my-app-container
fi

# 중지된 컨테이너가 있다면 삭제
if [ "$(sudo docker ps -a -q -f name=my-app-container)" ]; then
  echo "Existing container found. Removing..."
  sudo docker rm my-app-container
fi
