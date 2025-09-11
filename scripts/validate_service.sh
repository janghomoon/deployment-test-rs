#!/bin/bash
# 서비스 검증
echo "Validating service is healthy..."

# 헬스 체크 URL
HEALTH_CHECK_URL="http://localhost:8080/actuator/health"

STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" $HEALTH_CHECK_URL)

if [ "$STATUS_CODE" -ne 200 ]; then
  echo "Service validation failed. Status code: $STATUS_CODE"
  exit 1
fi

echo "Service validation successful. Status code: $STATUS_CODE"
