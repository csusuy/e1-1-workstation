#!/usr/bin/env bash
# ==============================================================================
# Codyssey E1-1: Terminal Basic Operations Practice Script
# ==============================================================================
set -e

echo "=== 1. 현재 작업 경로 확인 (pwd) ==="
pwd

echo -e "\n=== 2. 실습 디렉토리 생성 (mkdir -p) ==="
mkdir -p practice/subdir
ls -ld practice practice/subdir

echo -e "\n=== 3. 빈 파일 생성 및 내용 작성 (touch & echo) ==="
touch practice/file_empty.txt
echo "Codyssey E1-1 Developer Workstation" > practice/file_sample.txt
ls -la practice

echo -e "\n=== 4. 파일 내용 확인 (cat & head) ==="
cat practice/file_sample.txt

echo -e "\n=== 5. 파일 복사 (cp) ==="
cp practice/file_sample.txt practice/subdir/file_copied.txt
ls -la practice/subdir

echo -e "\n=== 6. 파일 이동 및 이름 변경 (mv) ==="
mv practice/subdir/file_copied.txt practice/subdir/file_renamed.txt
ls -la practice/subdir

echo -e "\n=== 7. 파일 및 디렉토리 삭제 (rm) ==="
rm practice/file_empty.txt
rm -r practice/subdir
ls -la practice

echo -e "\n[DONE] 터미널 기본 조작 실습 완료."
