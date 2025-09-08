# JRE 이미지를 기반으로 사용 (경량화)
FROM openjdk:17-jdk-slim

# 컨테이너 내에서 작업할 디렉토리 설정
WORKDIR /app

# Gradle 빌드 결과를 컨테이너로 복사
COPY build/libs/*.jar app.jar

# 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "app.jar"]
