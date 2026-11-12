#!/usr/bin/env bash
# ==============================================================================
# Codyssey E1-1: File & Directory Permission Practice Script
# ==============================================================================
set -e

echo "=== 1. 테스트 대상 파일 및 디렉토리 준비 ==="
mkdir -p perm_test_dir
touch perm_test_file.txt

echo -e "\n=== 2. 변경 전 초기 권한 확인 ==="
ls -ld perm_test_file.txt perm_test_dir

echo -e "\n=== 3. 파일 권한 변경 (chmod 644 -> rw-r--r--) ==="
chmod 644 perm_test_file.txt
ls -l perm_test_file.txt

echo -e "\n=== 4. 디렉토리 권한 변경 (chmod 755 -> rwxr-xr-x) ==="
chmod 755 perm_test_dir
ls -ld perm_test_dir

echo -e "\n=== 5. 실행 권한 추가 실험 (chmod +x) ==="
chmod +x perm_test_file.txt
ls -l perm_test_file.txt

# 정리
rm -rf perm_test_file.txt perm_test_dir
echo -e "\n[DONE] 권한 실습 완료."
