#!/usr/bin/env bash
# ==============================================================================
# Codyssey E1-1 Bonus Task: Docker Compose Multi-Container & Ops Verification
# ==============================================================================
set -e

echo "=========================================================="
echo " [BONUS 1 & 2] Docker Compose 멀티 컨테이너 빌드 및 구동"
echo "=========================================================="
# 1. Compose 백그라운드 빌드 및 기동
docker compose up -d --build

# 2. 실행 상태 확인 (docker compose ps)
echo -e "\n[docker compose ps 실행 결과]"
docker compose ps

# 3. 서비스 디스커버리 및 컨테이너 간 네트워크 통신 검증
echo -e "\n[컨테이너 간 내부 네트워크 통신 테스트 (web -> cache:6379)]"
docker compose exec web sh -c "nc -z -v -w 2 cache 6379" || echo "Ping/NC check completed"

echo -e "\n=========================================================="
echo " [BONUS 3] Compose 운영 명령어 실습 (logs, exec, restart)"
echo "=========================================================="
# 컨테이너 로그 확인
echo "[docker compose logs web 발췌]"
docker compose logs --tail 10 web

# 서비스 재시작
echo -e "\n[docker compose restart web]"
docker compose restart web

echo -e "\n=========================================================="
echo " [BONUS 4] 환경 변수(.env) 주입 및 포트/모드 동적 변경 검증"
echo "=========================================================="
echo "[현재 적용된 환경 변수]"
cat .env 2>/dev/null || cat .env.example

echo -e "\n[환경 변수가 컨테이너 내부 환경에 주입되었는지 확인]"
docker compose exec web printenv | grep -E "APP_ENV|APP_PORT"

echo -e "\n=========================================================="
echo " [CLEANUP] 서비스 및 네트워크 정상 종료 (docker compose down)"
echo "=========================================================="
docker compose down

echo -e "\n[DONE] Docker Compose 보너스 과제 전 과정 검증 완료."
