#!/bin/bash
# 새로운 환경으로 트래픽을 완전히 전환합니다.
# ALB 리스너 규칙을 수정하여 프로덕션 트래픽을 'green' 대상 그룹으로 보냅니다.

## 그립 타겟그룹 alb arn 확인
# 환경 변수 설정
ALB_LISTENER_ARN=$(aws elbv2 describe-listeners --load-balancer-arn [arn:aws:elasticloadbalancing:ap-northeast-2:217391774843:loadbalancer/app/blue-green-alb/8d1f191865307a4c] | jq -r '.Listeners[] | select(.Port == 80) | .ListenerArn')
NEW_TARGET_GROUP_ARN=$(aws elbv2 describe-target-groups --names green-target-group | jq -r '.TargetGroups[0].TargetGroupArn')

echo "### AllowTraffic: Shifting traffic to the new environment. ###"
echo "Listener ARN: $ALB_LISTENER_ARN"
echo "New Target Group ARN: $NEW_TARGET_GROUP_ARN"

# 리스너 규칙을 수정하여 모든 트래픽을 새로운 대상 그룹으로 포워딩
aws elbv2 modify-listener --listener-arn $ALB_LISTENER_ARN --default-actions '[{"Type": "forward", "TargetGroupArn": "$NEW_TARGET_GROUP_ARN"}]'

echo "### allow-traffic.sh complete ###"
