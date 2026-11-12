#!/usr/bin/env bash
# ==============================================================================
# Codyssey E1-1: Docker Installation, Build, and Execution Verification Script
# ==============================================================================
set -e

echo "=== 1. Docker 버전 및 데몬 점검 ==="
docker --version
docker info | grep -E "Server Version|Operating System|OSType|Architecture"

echo -e "\n=== 2. Hello-World 기본 이미지 실행 ==="
docker run --rm hello-world

echo -e "\n=== 3. Ubuntu 컨테이너 진입 및 비대화형 명령 실행 ==="
docker run --rm ubuntu bash -c "uname -a && cat /etc/os-release | grep PRETTY_NAME"

echo -e "\n=== 4. 커스텀 Dockerfile 빌드 ==="
docker build -t codyssey-web:1.0 .
docker images | grep codyssey-web

echo -e "\n=== 5. 포트 매핑 실행 (8080, 8081) ==="
# 8080 실행
docker run -d -p 8080:80 --name codyssey-web-8080 codyssey-web:1.0
# 8081 실행
docker run -d -p 8081:80 --name codyssey-web-8081 codyssey-web:1.0
docker ps --filter "name=codyssey-web"

echo -e "\n=== 6. 포트 매핑 접속 검증 (curl) ==="
sleep 2
echo "[Port 8080 Request]"
curl -I http://localhost:8080
echo -e "\n[Port 8081 Request]"
curl -I http://localhost:8081

echo -e "\n=== 7. 컨테이너 리소스 점검 및 정리 ==="
docker logs --tail 5 codyssey-web-8080
docker stop codyssey-web-8080 codyssey-web-8081
docker rm codyssey-web-8080 codyssey-web-8081

echo -e "\n[DONE] Docker 실행 및 포트 매핑 검증 완료."
