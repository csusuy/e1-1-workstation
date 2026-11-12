#!/usr/bin/env bash
# ==============================================================================
# Codyssey E1-1: Bind Mount & Volume Persistence Verification Script
# ==============================================================================
set -e

echo "=== PART 1: 바인드 마운트 실시간 변경 검증 ==="
# 임시 디렉토리 및 파일 생성
mkdir -p /tmp/mount-test
echo "Original Content" > /tmp/mount-test/index.html

# 바인드 마운트로 Nginx 실행
docker run -d -p 8082:80 -v /tmp/mount-test:/usr/share/nginx/html --name bind-test nginx:alpine
sleep 2

echo "[변경 전 curl]"
curl -s http://localhost:8082

echo "[호스트 파일 변경]"
echo "Updated Content via Bind Mount" > /tmp/mount-test/index.html

echo "[변경 후 curl (컨테이너 재시작 없이 반영 확인)]"
curl -s http://localhost:8082

docker rm -f bind-test
rm -rf /tmp/mount-test

echo -e "\n=== PART 2: Docker 볼륨 데이터 영속성 검증 ==="
# 1. 볼륨 생성
docker volume create codyssey-data
docker volume ls | grep codyssey-data

# 2. 첫 번째 컨테이너에서 데이터 파일 작성
docker run --rm -v codyssey-data:/data alpine sh -c "echo 'Persisted Data 2026' > /data/persistent.txt"

# 3. 두 번째 새로운 컨테이너에서 동일 볼륨 마운트 후 데이터 보존 확인
echo "[새 컨테이너에서 데이터 확인]"
docker run --rm -v codyssey-data:/data alpine cat /data/persistent.txt

# 4. 볼륨 정리
docker volume rm codyssey-data

echo -e "\n[DONE] 볼륨 영속성 검증 완료."
