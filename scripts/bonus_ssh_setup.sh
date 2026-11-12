#!/usr/bin/env bash
# ==============================================================================
# Codyssey E1-1 Bonus Task: GitHub SSH Key Generation & Verification Script
# ==============================================================================
set -e

KEY_PATH="$HOME/.ssh/id_ed25519"
EMAIL="wp03160@naver.com"

echo "=== 1. SSH 키 쌍 생성 (Ed25519 알고리즘) ==="
if [ ! -f "$KEY_PATH" ]; then
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
  ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_PATH" -N ""
  echo "SSH 키 생성 완료: $KEY_PATH"
else
  echo "이미 존재하는 SSH 키를 재사용합니다: $KEY_PATH"
fi

echo -e "\n=== 2. SSH 공개키 확인 (GitHub 등록용) ==="
cat "${KEY_PATH}.pub"

echo -e "\n=== 3. ~/.ssh/config 최적화 설정 ==="
CONFIG_PATH="$HOME/.ssh/config"
if ! grep -q "Host github.com" "$CONFIG_PATH" 2>/dev/null; then
  cat << EOF >> "$CONFIG_PATH"

Host github.com
  HostName github.com
  User git
  IdentityFile $KEY_PATH
  IdentitiesOnly yes
EOF
  chmod 600 "$CONFIG_PATH"
  echo "SSH 설정 파일(~/.ssh/config) 갱신 완료"
fi

echo -e "\n=== 4. GitHub SSH 연결 테스트 ==="
echo "명령어: ssh -T git@github.com -o StrictHostKeyChecking=accept-new"
ssh -T git@github.com -o StrictHostKeyChecking=accept-new || true

echo -e "\n[DONE] SSH 키 설정 및 검증 준비 완료."
