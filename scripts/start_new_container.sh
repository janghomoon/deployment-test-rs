#!/bin/bash
# 최신 Docker 이미지 가져와서 새 컨테이너 실행
echo "Pulling latest Docker image and starting a new container..."

# 필요한 변수 설정
ECR_REGISTRY="[YOUR_ECR_REGISTRY_URL]" # ECR 레지스트리 URL로 변경
ECR_REPOSITORY="my-spring-boot-repo"
IMAGE_NAME="my-spring-boot-app"

# AWS CLI를 사용하여 ECR에 로그인
echo "Logging in to Amazon ECR..."
aws ecr get-login-password --region ap-northeast-2 | sudo docker login --username AWS --password-stdin $ECR_REGISTRY

# 최신 이미지 pull
echo "Pulling latest image from ECR..."
sudo docker pull $ECR_REGISTRY/$ECR_REPOSITORY:latest

# 새 Docker 컨테이너 실행
echo "Starting new Docker container..."
sudo docker run -d -p 8080:8080 --name $IMAGE_NAME $ECR_REGISTRY/$ECR_REPOSITORY:latest
