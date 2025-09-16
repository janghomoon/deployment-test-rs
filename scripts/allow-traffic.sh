#!/bin/bash
# 새로운 환경으로 트래픽을 완전히 전환합니다.
# ALB 리스너 규칙을 수정하여 프로덕션 트래픽을 'green' 대상 그룹으로 보냅니다.

# 환경 변수 설정
# ---------------------
# TODO: YOUR_ALB_ARN을 실제 ALB의 ARN으로 변경하세요.
# ALB_ARN은 AWS 콘솔의 EC2 > 로드 밸런서에서 확인할 수 있습니다.
ALB_ARN="arn:aws:elasticloadbalancing:ap-northeast-2:217391774843:loadbalancer/app/blue-green-alb/8d1f191865307a4c"

# TODO: green-tg가 아닌 다른 이름을 사용했다면 아래 이름을 변경하세요.
TARGET_GROUP_NAME="green-target-group"

ALB_LISTENER_ARN=$(aws elbv2 describe-listeners --load-balancer-arn "$ALB_ARN" | jq -r '.Listeners[] | select(.Port == 80) | .ListenerArn')
NEW_TARGET_GROUP_ARN=$(aws elbv2 describe-target-groups --names "$TARGET_GROUP_NAME" | jq -r '.TargetGroups[0].TargetGroupArn')

echo "### AllowTraffic: Shifting traffic to the new environment. ###"
echo "Listener ARN: $ALB_LISTENER_ARN"
echo "New Target Group ARN: $NEW_TARGET_GROUP_ARN"

# 리스너 규칙을 수정하여 모든 트래픽을 새로운 대상 그룹으로 포워딩
aws elbv2 modify-listener --listener-arn "$ALB_LISTENER_ARN" --default-actions '[{"Type": "forward", "TargetGroupArn": "'"$NEW_TARGET_GROUP_ARN"'"}]'

echo "### allow-traffic.sh complete ###"

