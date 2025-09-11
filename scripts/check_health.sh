#!/bin/bash
# 애플리케이션 헬스 체크
echo "Waiting for application to start..."
sleep 10
echo "Checking application health..."

# 헬스 체크 URL
HEALTH_CHECK_URL="http://localhost:8080/actuator/health"

for i in {1..30}; do
  STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" $HEALTH_CHECK_URL)
  if [ "$STATUS_CODE" -eq 200 ]; then
    echo "Health check passed. Application is running."
    exit 0
  fi
  echo "Health check failed with status code $STATUS_CODE. Retrying in 2 seconds..."
  sleep 2
done

echo "Application failed to start after multiple retries."
exit 1
