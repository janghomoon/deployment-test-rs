#!/bin/bash
# 트래픽 전환 완료 후 최종 정리 작업 수행

echo "### AfterAllowTraffic: Cleaning up old instances. ###"

# CodeDeploy가 이전 인스턴스를 자동으로 종료하도록 설정했다면 이 스크립트는 필요하지 않을 수 있습니다.
# 수동으로 이전 환경의 인스턴스를 종료하려면 아래와 같은 로직을 추가할 수 있습니다.

# 예시: 특정 태그를 가진 인스턴스 종료
# INSTANCE_IDS=$(aws ec2 describe-instances --filters "Name=tag:deployment-status,Values=blue" --query "Reservations[].Instances[].InstanceId" --output text)
# if [ -n "$INSTANCE_IDS" ]; then
#   aws ec2 terminate-instances --instance-ids $INSTANCE_IDS
#   echo "Terminated old blue instances: $INSTANCE_IDS"
# fi

echo "### after-allow-traffic.sh complete ###"
