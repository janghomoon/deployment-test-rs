##!/bin/bash
## 최신 Docker 이미지 가져와서 새 컨테이너 실행
#echo "Pulling latest Docker image and starting a new container..."
#
## 필요한 변수 설정
#ECR_REGISTRY="217391774843.dkr.ecr.ap-northeast-2.amazonaws.com" # ECR 레지스트리 URL로 변경
#ECR_REPOSITORY="jhm/ci-cd-test"
#IMAGE_NAME="jhm-test-cd"
#
## AWS CLI를 사용하여 ECR에 로그인
#echo "Logging in to Amazon ECR..."
#aws ecr get-login-password --region ap-northeast-2 | sudo docker login --username AWS --password-stdin $ECR_REGISTRY
#
## 최신 이미지 pull
#echo "Pulling latest image from ECR..."
#sudo docker pull $ECR_REGISTRY/$ECR_REPOSITORY:latest
#
## 새 Docker 컨테이너 실행
#echo "Starting new Docker container..."
#sudo docker run -d -p 8080:8080 --name $IMAGE_NAME $ECR_REGISTRY/$ECR_REPOSITORY:latest


#!/bin/bash
set -e  # 에러 발생 시 스크립트 중단

# 환경 변수 설정
ECR_REGISTRY="217391774843.dkr.ecr.ap-northeast-2.amazonaws.com"
ECR_REPOSITORY="jhm/ci-cd-test"
IMAGE_NAME="jhm-test-cd"
CONTAINER_NAME="jhm-test-app"  # 실제 실행할 컨테이너 이름 (IMAGE_NAME과 분리)

echo "=== [1] ECR 로그인 ==="
aws ecr get-login-password --region ap-northeast-2 | \
    sudo docker login --username AWS --password-stdin $ECR_REGISTRY

echo "=== [2] 기존 컨테이너 정리 ==="
if [ "$(sudo docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Stopping and removing existing container: $CONTAINER_NAME"
    sudo docker stop $CONTAINER_NAME || true
    sudo docker rm $CONTAINER_NAME || true
fi

echo "=== [3] 최신 이미지 Pull ==="
sudo docker pull $ECR_REGISTRY/$ECR_REPOSITORY:latest

echo "=== [4] 새 컨테이너 실행 ==="
sudo docker run -d \
  --name $CONTAINER_NAME \
  -p 8080:8080 \
  $ECR_REGISTRY/$ECR_REPOSITORY:latest

echo "=== [5] 실행된 컨테이너 확인 ==="
sudo docker ps -f name=$CONTAINER_NAME

echo "New application container started successfully!"
