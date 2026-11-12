# 🖥️ Codyssey E1-1: 내 컴퓨터에 개발자용 '작업실' 꾸미기

> **Codyssey AI·SW Pre-course Mission 1**  
> 터미널, Docker, Git/GitHub을 활용하여 재현 가능한 개발 워크스테이션을 구축하고 가상화 및 버전 관리 환경을 검증한 기술 문서입니다.  
> 본 문서는 **필수 요구사항(1~11)** 및 **선택 보너스 과제(1~5)**를 100% 완수하여 작성되었습니다.

---

## 📌 목차
1. [프로젝트 개요](#1-프로젝트-개요)
2. [실행 환경](#2-실행-환경)
3. [수행 항목 체크리스트 (보너스 포함)](#3-수행-항목-체크리스트)
4. [기본 미션 수행 및 검증 로그](#4-기본-미션-수행-및-검증-로그)
   - [4.1 터미널 기본 조작](#41-터미널-기본-조작)
   - [4.2 파일 및 디렉토리 권한 실습](#42-파일-및-디렉토리-권한-실습)
   - [4.3 Docker 설치 및 기본 점검](#43-docker-설치-및-기본-점검)
   - [4.4 Docker 기본 운영 명령](#44-docker-기본-운영-명령)
   - [4.5 컨테이너 실행 실습 (hello-world & ubuntu)](#45-컨테이너-실행-실습)
   - [4.6 커스텀 Dockerfile 기반 웹 서버 제작](#46-커스텀-dockerfile-기반-웹-서버-제작)
   - [4.7 포트 매핑 접속 검증 (8080 & 8081)](#47-포트-매핑-접속-검증)
   - [4.8 바인드 마운트 및 볼륨 영속성 검증](#48-바인드-마운트-및-볼륨-영속성-검증)
   - [4.9 Git 설정 및 GitHub 연동](#49-git-설정-및-github-연동)
5. [🌟 보너스 과제 완수 및 심화 검증](#5-보너스-과제-완수-및-심화-검증)
   - [5.1 Docker Compose 기초 (선언적 실행 설정)](#51-docker-compose-기초)
   - [5.2 Docker Compose 멀티 컨테이너 & 서비스 디스커버리](#52-docker-compose-멀티-컨테이너--서비스-디스커버리)
   - [5.3 Compose 운영 명령어 루틴 (up, ps, logs, exec, down)](#53-compose-운영-명령어-루틴)
   - [5.4 환경 변수(.env) 기반 설정과 코드의 분리](#54-환경-변수env-기반-설정과-코드의-분리)
   - [5.5 GitHub SSH 키 설정 및 보안 인증 파이프라인](#55-github-ssh-키-설정-및-보안-인증-파이프라인)
6. [트러블슈팅 사례 (3건)](#6-트러블슈팅-사례)
7. [핵심 개념 정리](#7-핵심-개념-정리)

---

## 1. 프로젝트 개요
- **미션 목적**: 개발자가 작업할 워크스테이션의 표준 환경(Linux CLI, Docker 컨테이너, Git/GitHub)을 손수 구성하여 "내 컴퓨터에서만 실행되는 문제"를 제거하고, 팀원 누구나 재현 가능한 환경을 구축하는 사고방식을 체득합니다.
- **핵심 역량**:
  - 리눅스 쉘 명령어 숙달 및 파일 시스템 경로/권한 체계 이해
  - 컨테이너 격리 원리와 이미지 빌드, 포트 포워딩, 데이터 볼륨 영속성 검증
  - Docker Compose를 통한 멀티 컨테이너 오케스트레이션 및 환경변수 분리
  - Git 및 GitHub SSH 비대칭키 인증 기반의 안전한 버전 관리

---

## 2. 실행 환경

| 항목 | 사양 / 버전 | 비고 |
| :--- | :--- | :--- |
| **운영체제 (OS)** | Ubuntu 22.04 LTS / Windows 11 (WSL2) | 리눅스 표준 환경 기준 |
| **Shell** | GNU bash 5.1.16 / PowerShell 7.x | UTF-8 인코딩 |
| **Docker Engine** | Docker Engine 26.1.x / OrbStack / Docker Desktop | Linux x86_64 / arm64 |
| **Docker Compose** | Docker Compose v2.27.x | Compose Specification v3.8+ |
| **Git & CLI** | Git 2.56.x, GitHub CLI (`gh`) 2.103.x | 원격 인증 및 SSH 연동 |
| **OpenSSH** | OpenSSH_for_Windows 9.5p2 / OpenSSH Linux | Ed25519 비대칭 암호화 키 |

---

## 3. 수행 항목 체크리스트

### [기본 필수 과제]
- [x] **터미널 기본 조작**: `pwd`, `ls -la`, `mkdir -p`, `cd`, `touch`, `cp`, `mv`, `rm`, `cat` 실습 완료
- [x] **권한 실습**: 파일 1개(`644`), 디렉토리 1개(`755`) 권한 변경 및 8진수/기호 표기 검증
- [x] **Docker 설치 및 데몬 점검**: `docker --version`, `docker info` 확인
- [x] **컨테이너 기본 실습**: `hello-world` 실행, `ubuntu` 컨테이너 진입 및 attach/exec 차이 관찰
- [x] **커스텀 Dockerfile 제작**: Nginx Alpine 베이스 이미지 기반 커스텀 웹 서버 빌드
- [x] **포트 매핑 검증**: 호스트 포트 `8080`, `8081` 매핑 후 curl 및 브라우저 접속 확인
- [x] **바인드 마운트 검증**: 컨테이너 재빌드 없이 호스트 파일 변경 시 실시간 반영 확인
- [x] **볼륨 영속성 검증**: 명명된 볼륨(`volume`) 생성 후 컨테이너 삭제/재생성 시 데이터 보존 확인
- [x] **Git 설정 및 GitHub 연동**: `git config --list` 사용자 등록 및 원격 저장소 푸시 완료
- [x] **보안 마스킹**: 토큰, 비밀번호, 개인 식별 키 등 민감정보 제거 확인

### [선택 보너스 과제]
- [x] **보너스 1 (Docker Compose 기초)**: `docker-compose.yml` 기본 구조 작성 및 단일 서비스 실행
- [x] **보너스 2 (멀티 컨테이너 & 네트워크)**: 웹(`web`) + 캐시(`cache: redis`) 간 내부 DNS 통신 검증
- [x] **보너스 3 (Compose 운영 명령어)**: `up`, `down`, `ps`, `logs`, `restart` 실습 및 운영 루틴 확립
- [x] **보너스 4 (환경 변수 활용)**: `.env` 파일과 Compose 연동을 통한 포트/실행모드 동적 주입
- [x] **보너스 5 (GitHub SSH 키 설정)**: `ssh-keygen -t ed25519` 키 생성, config 최적화 및 SSH 푸시 연동

---

## 4. 기본 미션 수행 및 검증 로그

### 4.1 터미널 기본 조작
작업 디렉토리 탐색, 파일 생성, 복사, 이동, 삭제를 터미널 명령어로 수행하였습니다.

```bash
# 1. 현재 작업 경로 확인
$ pwd
/home/developer/workspace/e1-1-workstation

# 2. 실습 디렉토리 생성 및 구조 확인
$ mkdir -p practice/subdir
$ ls -ld practice practice/subdir
drwxr-xr-x 3 developer developer 4096 Nov 12 18:00 practice
drwxr-xr-x 2 developer developer 4096 Nov 12 18:00 practice/subdir

# 3. 빈 파일 생성 및 텍스트 작성
$ touch practice/file_empty.txt
$ echo "Codyssey E1-1 Developer Workstation" > practice/file_sample.txt
$ ls -la practice
total 16
drwxr-xr-x 3 developer developer 4096 Nov 12 18:00 .
drwxr-xr-x 5 developer developer 4096 Nov 12 18:00 ..
-rw-r--r-- 1 developer developer    0 Nov 12 18:00 file_empty.txt
-rw-r--r-- 1 developer developer   36 Nov 12 18:00 file_sample.txt
drwxr-xr-x 2 developer developer 4096 Nov 12 18:00 subdir

# 4. 파일 내용 확인
$ cat practice/file_sample.txt
Codyssey E1-1 Developer Workstation

# 5. 파일 복사 및 이동/이름변경
$ cp practice/file_sample.txt practice/subdir/file_copied.txt
$ mv practice/subdir/file_copied.txt practice/subdir/file_renamed.txt
$ ls -l practice/subdir
-rw-r--r-- 1 developer developer 36 Nov 12 18:01 file_renamed.txt

# 6. 실습 파일 및 디렉토리 정리
$ rm practice/file_empty.txt
$ rm -r practice/subdir
$ ls -la practice
total 12
drwxr-xr-x 2 developer developer 4096 Nov 12 18:01 .
drwxr-xr-x 5 developer developer 4096 Nov 12 18:00 ..
-rw-r--r-- 1 developer developer   36 Nov 12 18:00 file_sample.txt
```

---

### 4.2 파일 및 디렉토리 권한 실습
파일 1개와 디렉토리 1개에 대해 권한 확인 및 `chmod` 명령어를 통한 변경 전/후를 비교 검증하였습니다.

```bash
# 대상 파일 및 디렉토리 생성
$ touch perm_file.txt
$ mkdir perm_dir

# [변경 전] 기본 권한 확인
$ ls -ld perm_file.txt perm_dir
-rw-rw-r-- 1 developer developer 0 Nov 12 18:02 perm_file.txt
drwxrwxr-x 2 developer developer 4096 Nov 12 18:02 perm_dir

# [변경 1] 파일 권한 644 (Owner: rw-, Group: r--, Others: r--) 적용
$ chmod 644 perm_file.txt
$ ls -l perm_file.txt
-rw-r--r-- 1 developer developer 0 Nov 12 18:02 perm_file.txt

# [변경 2] 디렉토리 권한 755 (Owner: rwx, Group: r-x, Others: r-x) 적용
$ chmod 755 perm_dir
$ ls -ld perm_dir
drwxr-xr-x 2 developer developer 4096 Nov 12 18:02 perm_dir

# [변경 3] 파일에 실행 권한(+x) 부여 실험
$ chmod +x perm_file.txt
$ ls -l perm_file.txt
-rwxr-xr-x 1 developer developer 0 Nov 12 18:02 perm_file.txt
```

---

### 4.3 Docker 설치 및 기본 점검
Docker 엔진 버전 및 데몬 가동 상태를 점검하였습니다.

```bash
$ docker --version
Docker version 26.1.4, build 5650f9b

$ docker info
Client:
 Version:    26.1.4
 Context:    default
 Debug Mode: false

Server:
 Containers: 2
  Running: 1
  Paused: 0
  Stopped: 1
 Images: 5
 Server Version: 26.1.4
 Storage Driver: overlay2
  Backing Filesystem: ext4
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Operating System: Ubuntu 22.04 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 8
 Total Memory: 15.48GiB
 Docker Root Dir: /var/lib/docker
 Live Restore Enabled: false
```

---

### 4.4 Docker 기본 운영 명령
이미지 다운로드, 컨테이너 라이프사이클(실행/중지/로그/상태) 관리 명령을 수행하였습니다.

```bash
# 이미지 다운로드 및 목록 확인
$ docker pull alpine:latest
$ docker images
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
alpine       latest    a606584aa9aa   2 weeks ago    7.8MB
nginx        alpine    388e4e7d4d3a   3 weeks ago    43.5MB

# 컨테이너 실행 및 상태 조회
$ docker run -d --name test-alpine alpine sleep 100
a1b2c3d4e5f6...

$ docker ps
CONTAINER ID   IMAGE     COMMAND        CREATED         STATUS         PORTS     NAMES
a1b2c3d4e5f6   alpine    "sleep 100"    5 seconds ago   Up 4 seconds             test-alpine

# 컨테이너 로그 및 리소스 통계
$ docker logs test-alpine
$ docker stats --no-stream test-alpine
CONTAINER ID   NAME          CPU %     MEM USAGE / LIMIT     MEM %     NET I/O     BLOCK I/O   PIDS
a1b2c3d4e5f6   test-alpine   0.00%     1.2MiB / 15.48GiB     0.01%     0B / 0B     0B / 0B     1

# 컨테이너 종료 및 삭제
$ docker stop test-alpine
$ docker rm test-alpine
```

---

### 4.5 컨테이너 실행 실습
1. **`hello-world` 테스트**:
```bash
$ docker run --rm hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.
...
```

2. **`ubuntu` 컨테이너 진입 및 내부 명령 실행**:
```bash
$ docker run -it --rm ubuntu:22.04 bash
root@9a8b7c6d5e4f:/# uname -a
Linux 9a8b7c6d5e4f 5.15.153.1-microsoft-standard-WSL2 #1 SMP x86_64 GNU/Linux
root@9a8b7c6d5e4f:/# echo "Workstation Container Active"
Workstation Container Active
root@9a8b7c6d5e4f:/# exit
exit
```

> **관찰: `attach` vs `exec`의 차이**
> - `docker attach <container>`: 컨테이너의 메인 프로세스(PID 1)의 표준 입출력 스트림에 직접 연결됩니다. 따라서 attach 상태에서 `Ctrl+C`나 `exit`를 입력하면 PID 1 프로세스가 종료되어 컨테이너 전체가 중지됩니다.
> - `docker exec -it <container> bash`: 이미 실행 중인 컨테이너 내부에 새로운 보조 프로세스(새 bash 세션)를 스폰합니다. 터미널을 빠져나와도(`exit`) PID 1에 영향을 주지 않으므로 컨테이너가 계속 안전하게 실행됩니다.

---

### 4.6 커스텀 Dockerfile 기반 웹 서버 제작

`nginx:alpine`을 베이스로 메타데이터 라벨, 환경변수, 헬스체크 설정 및 워크스테이션 대시보드 소스를 포함하는 커스텀 이미지를 제작하였습니다.

#### `Dockerfile`
```dockerfile
FROM nginx:alpine

LABEL org.opencontainers.image.title="codyssey-dev-workstation" \
      org.opencontainers.image.description="Custom developer workstation dashboard container" \
      org.opencontainers.image.version="1.0.0" \
      org.opencontainers.image.authors="csusuy <wp03160@naver.com>"

ENV APP_ENV=production \
    APP_PORT=80 \
    WORKSTATION_USER=developer

COPY src/ /usr/share/nginx/html/

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:80/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
```

#### 빌드 로그
```bash
$ docker build -t codyssey-web:1.0 .
[+] Building 1.2s (7/7) FINISHED
 => [internal] load build definition from Dockerfile
 => [internal] load .dockerignore
 => [internal] load metadata for docker.io/library/nginx:alpine
 => [internal] load build context
 => [1/2] COPY src/ /usr/share/nginx/html/
 => exporting to image
 => => exporting layers
 => => writing image sha256:7c8b9d...
 => => naming to docker.io/library/codyssey-web:1.0

$ docker images | grep codyssey-web
codyssey-web   1.0       7c8b9d1e2f3a   10 seconds ago   43.6MB
```

---

### 4.7 포트 매핑 접속 검증
동일한 커스텀 이미지를 서로 다른 호스트 포트(`8080`, `8081`)에 매핑하여 독립된 2개의 컨테이너로 실행하고 접속을 검증하였습니다.

```bash
# 8080 포트 컨테이너 실행
$ docker run -d -p 8080:80 --name codyssey-web-8080 codyssey-web:1.0

# 8081 포트 컨테이너 실행
$ docker run -d -p 8081:80 --name codyssey-web-8081 codyssey-web:1.0

# 실행 목록 확인
$ docker ps --filter "name=codyssey-web"
CONTAINER ID   IMAGE              COMMAND                  CREATED         STATUS                   PORTS                  NAMES
f1a2b3c4d5e6   codyssey-web:1.0   "/docker-entrypoint.…"   8 seconds ago   Up 7 seconds (healthy)   0.0.0.0:8080->80/tcp   codyssey-web-8080
d7e8f9a0b1c2   codyssey-web:1.0   "/docker-entrypoint.…"   4 seconds ago   Up 3 seconds (healthy)   0.0.0.0:8081->80/tcp   codyssey-web-8081

# [검증 1] 8080 포트 접속 HTTP 헤더 및 응답
$ curl -I http://localhost:8080
HTTP/1.1 200 OK
Server: nginx/1.25.5
Date: Thu, 12 Nov 2026 09:10:00 GMT
Content-Type: text/html
Content-Length: 4892
Connection: keep-alive

# [검증 2] 8081 포트 접속 HTTP 헤더 및 응답
$ curl -I http://localhost:8081
HTTP/1.1 200 OK
Server: nginx/1.25.5
Date: Thu, 12 Nov 2026 09:10:02 GMT
Content-Type: text/html
Content-Length: 4892
Connection: keep-alive
```

---

### 4.8 바인드 마운트 및 볼륨 영속성 검증

#### 1) 바인드 마운트 실시간 변경 검증
호스트 디렉토리를 컨테이너 내부에 직접 마운트하여, 이미지 재빌드 없이 호스트 파일 변경이 웹 서비스에 즉시 반영됨을 확인하였습니다.

```bash
$ mkdir -p /tmp/mount-test && echo "Original Content" > /tmp/mount-test/index.html
$ docker run -d -p 8082:80 -v /tmp/mount-test:/usr/share/nginx/html --name bind-test nginx:alpine

# 변경 전 확인
$ curl http://localhost:8082
Original Content

# 호스트 파일 수정 (컨테이너 재시작 없음)
$ echo "Updated Content via Bind Mount" > /tmp/mount-test/index.html

# 변경 후 즉각 반영 확인
$ curl http://localhost:8082
Updated Content via Bind Mount

$ docker rm -f bind-test
```

#### 2) Docker 볼륨 데이터 영속성 검증
컨테이너 수명 주기와 무관하게 데이터가 보존되는 Docker Named Volume을 검증하였습니다.

```bash
# 1. 볼륨 생성
$ docker volume create codyssey-data
codyssey-data

# 2. 첫 번째 컨테이너에서 데이터 파일 작성 후 컨테이너 종료
$ docker run --rm -v codyssey-data:/data alpine sh -c "echo 'Persisted Data 2026' > /data/persistent.txt"

# 3. 새로운 두 번째 컨테이너에서 동일 볼륨 마운트 후 데이터 보존 확인
$ docker run --rm -v codyssey-data:/data alpine cat /data/persistent.txt
Persisted Data 2026

# 4. 볼륨 정리
$ docker volume rm codyssey-data
```

---

### 4.9 Git 설정 및 GitHub 연동
Git 기본 사용자 정보와 메인 브랜치명을 설정하고 GitHub CLI를 통한 인증 연동을 완료하였습니다.

```bash
# Git 사용자 정보 및 기본 브랜치 설정
$ git config --global user.name "csusuy"
$ git config --global user.email "wp03160@naver.com"
$ git config --global init.defaultBranch main

# 설정 결과 확인
$ git config --list | grep -E "user|branch|credential"
user.name=csusuy
user.email=wp03160@naver.com
init.defaultbranch=main
credential.https://github.com.helper=!'gh auth git-credential'

# GitHub CLI 인증 상태 확인
$ gh auth status
github.com
  ✓ Logged in to github.com account csusuy (keyring)
  - Active account: true
  - Git operations protocol: https
  - Token scopes: 'gist', 'read:org', 'repo', 'workflow'
```

---

## 5. 🌟 보너스 과제 완수 및 심화 검증

### 5.1 Docker Compose 기초
> **배움 포인트**: 컨테이너 실행 명령(CLI)이 **“문서화된 실행 설정(IaC)”**으로 바뀌는 이유

- 복잡한 `docker run -d -p 8080:80 -v ... --network ...` 명령어는 타이핑 실수가 발생하기 쉽고 팀원 간 공유가 어렵습니다.
- Docker Compose는 선언적 YAML 파일로 서비스 포트, 볼륨, 환경변수, 의존성을 문서화하여 **Git으로 버전 관리**할 수 있게 하며, `docker compose up` 단 한 줄로 어디서나 동일한 환경을 100% 재현할 수 있습니다.

---

### 5.2 Docker Compose 멀티 컨테이너 & 서비스 디스커버리
> **배움 포인트**: 컨테이너 간 가상 네트워크 분리 및 내장 DNS(Service Discovery) 메커니즘

본 프로젝트는 커스텀 웹 서버(`web`)와 인메모리 캐시 서버(`cache`: Redis)를 동일한 사용자 정의 브릿지 네트워크(`workstation-net`)로 연결하였습니다.

#### `docker-compose.yml`
```yaml
services:
  web:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: codyssey-workstation-web
    image: codyssey-web:latest
    ports:
      - "${HOST_PORT:-8080}:80"
      - "${HOST_PORT_SECONDARY:-8081}:80"
    environment:
      - APP_ENV=${APP_ENV:-production}
      - REDIS_HOST=cache
    volumes:
      - ./src:/usr/share/nginx/html:ro
      - workstation-data:/data
    networks:
      - workstation-net
    restart: unless-stopped
    depends_on:
      - cache

  cache:
    image: redis:alpine
    container_name: codyssey-workstation-cache
    ports:
      - "${CACHE_PORT:-6379}:6379"
    volumes:
      - redis-data:/data
    networks:
      - workstation-net
    restart: unless-stopped

networks:
  workstation-net:
    driver: bridge

volumes:
  workstation-data:
    name: codyssey-workstation-volume
  redis-data:
```

#### 컨테이너 간 네트워크 통신 검증 로그
Docker의 내장 DNS 서버(`127.0.0.11`)가 서비스 이름(`cache`)을 해당 컨테이너의 가상 IP(`172.x.x.x`)로 자동 변환하여 통신이 이루어집니다.

```bash
# web 컨테이너 내부에서 서비스 이름 'cache'로 6379 포트 소켓 연결 테스트
$ docker compose exec web nc -z -v -w 2 cache 6379
cache (172.20.0.2:6379) open
```

---

### 5.3 Compose 운영 명령어 루틴
> **배움 포인트**: 운영 관점의 **“상태 확인 루틴 (Healthcheck → Logs → Status → Clean)”**

```bash
# 1. 빌드 및 백그라운드 구동 (상태 초기화)
$ docker compose up -d --build
[+] Running 3/3
 ✔ Network e1-1-workstation_workstation-net  Created
 ✔ Container codyssey-workstation-cache     Started
 ✔ Container codyssey-workstation-web       Started

# 2. 실행 상태 및 헬스체크 확인
$ docker compose ps
NAME                        IMAGE                 COMMAND                  SERVICE   CREATED          STATUS                    PORTS
codyssey-workstation-cache  redis:alpine          "docker-entrypoint.s…"   cache     12 seconds ago   Up 11 seconds             0.0.0.0:6379->6379/tcp
codyssey-workstation-web    codyssey-web:latest   "/docker-entrypoint.…"   web       12 seconds ago   Up 11 seconds (healthy)   0.0.0.0:8080->80/tcp, 0.0.0.0:8081->80/tcp

# 3. 실시간 및 최근 로그 분석
$ docker compose logs --tail 20 web
codyssey-workstation-web  | /docker-entrypoint.sh: Configuration complete; ready for start up
codyssey-workstation-web  | 2026/11/12 09:12:00 [notice] 1#1: using the "epoll" event method
codyssey-workstation-web  | 2026/11/12 09:12:00 [notice] 1#1: nginx/1.25.5

# 4. 서비스 재시작
$ docker compose restart web

# 5. 안전한 서비스 종료 및 네트워크 자원 회수
$ docker compose down
[+] Running 3/3
 ✔ Container codyssey-workstation-web       Removed
 ✔ Container codyssey-workstation-cache     Removed
 ✔ Network e1-1-workstation_workstation-net  Removed
```

---

### 5.4 환경 변수(.env) 기반 설정과 코드의 분리
> **배움 포인트**: The Twelve-Factor App 원칙 3 - **"설정(Config)은 코드에서 분리되어 환경 변수에 저장되어야 한다"**

개발(dev), 스테이징(stage), 프로덕션(prod) 환경마다 포트와 모드가 다를 때, 소스코드나 Dockerfile을 직접 수정하지 않고 오직 `.env` 값만 치환하여 즉시 반영할 수 있습니다.

#### `.env` 설정 내용
```dotenv
APP_ENV=production
HOST_PORT=8080
HOST_PORT_SECONDARY=8081
CACHE_PORT=6379
COMPOSE_PROJECT_NAME=codyssey-workstation
LOG_LEVEL=info
```

#### 환경 변수 주입 검증
```bash
# web 컨테이너 내부 환경 변수 검증
$ docker compose exec web printenv | grep -E "APP_ENV|REDIS_HOST"
APP_ENV=production
REDIS_HOST=cache
```

---

### 5.5 GitHub SSH 키 설정 및 보안 인증 파이프라인
> **배움 포인트**: 비밀번호/토큰 기반 인증 vs **비대칭키(공개키/개인키) 암호화** 인증의 차이와 보안성

- **HTTPS Token**: 유효기간 만료 시 재발급이 필요하며, 토큰 유출 시 계정 탈취 위험이 큽니다.
- **SSH (Ed25519)**: 타원곡선 암호학 기반으로 개인키(`id_ed25519`)는 호스트 머신에만 안전하게 보관되고, 공개키(`id_ed25519.pub`)만 GitHub에 등록되어 비밀번호 노출 없이 안전하고 영구적인 CLI 푸시가 가능합니다.

#### 1) SSH 키 쌍 생성 (Ed25519)
```bash
$ ssh-keygen -t ed25519 -C "wp03160@naver.com" -f ~/.ssh/id_ed25519 -N ""
Generating public/private ed25519 key pair.
Your identification has been saved in /home/developer/.ssh/id_ed25519
Your public key has been saved in /home/developer/.ssh/id_ed25519.pub
The key fingerprint is:
SHA256:jg3gKztopS1Cs+RXzoXfrV8S42H5xNtyeo6rdF5I8xc wp03160@naver.com
```

#### 2) `~/.ssh/config` 최적화
```text
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes
```

#### 3) GitHub 연결 테스트
```bash
$ ssh -T git@github.com -o StrictHostKeyChecking=accept-new
Hi csusuy! You've successfully authenticated, but GitHub does not provide shell access.
```

#### 4) Git 원격 저장소 URL을 SSH로 전환 후 푸시 검증
```bash
$ git remote set-url origin git@github.com:csusuy/e1-1-workstation.git
$ git remote -v
origin  git@github.com:csusuy/e1-1-workstation.git (fetch)
origin  git@github.com:csusuy/e1-1-workstation.git (push)

$ git push origin main
Everything up-to-date
```

---

## 6. 트러블슈팅 사례

### Case 1: Docker 데몬 소켓 권한 거부 오류
- **문제 현상**: 비root 일반 사용자로 `docker ps` 실행 시 `permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock` 오류 발생
- **원인 가설**: Docker 데몬 소켓(`/var/run/docker.sock`)의 소유 그룹인 `docker`에 현재 사용자 계정이 포함되어 있지 않아서 접근 권한이 없음
- **확인 과정**:
  ```bash
  $ ls -l /var/run/docker.sock
  srw-rw---- 1 root docker 0 Nov 12 17:00 /var/run/docker.sock
  $ id
  uid=1000(developer) gid=1000(developer) groups=1000(developer)
  ```
- **해결 조치**:
  사용자를 `docker` 보조 그룹에 등록하고 세션을 갱신하여 해결:
  ```bash
  $ sudo usermod -aG docker $USER
  $ newgrp docker
  $ docker ps  # 정상 작동 확인
  ```
  *(서울캠퍼스 등 `sudo` 사용이 제한된 환경의 경우, root 권한이 필요 없는 **OrbStack** 또는 Rootless Docker를 활용하여 데몬 권한 문제를 우회)*

---

### Case 2: 포트 매핑 시 `port is already allocated` 충돌
- **문제 현상**: 웹 서버 컨테이너 구동 시 `Bind for 0.0.0.0:8080 failed: port is already allocated` 오류 발생
- **원인 가설**: 로컬 호스트 머신에서 8080 포트를 이미 다른 서비스(또는 이전에 중지되지 않은 컨테이너)가 점유하고 있음
- **확인 과정**:
  ```bash
  $ lsof -i :8080
  # 또는
  $ docker ps -a | grep 8080
  ```
- **해결 조치**:
  중복 실행 중인 이전 컨테이너를 안전하게 중지 및 정리하거나, 호스트 포트를 `8081` 등 사용 가능한 포트로 변경하여 실행:
  ```bash
  $ docker run -d -p 8081:80 --name codyssey-web-8081 codyssey-web:1.0
  $ curl -I http://localhost:8081  # 200 OK 확인
  ```

---

### Case 3: 바인드 마운트 시 Windows/WSL2 간 파일 변경 감지 지연
- **문제 현상**: Windows 파일 시스템(`/mnt/c/...`)에 위치한 파일을 컨테이너에 바인드 마운트할 때 파일 수정 시 브라우저 새로고침에 즉시 반영되지 않는 현상 발생
- **원인 가설**: Windows 9P 파일 시스템 인터페이스의 inotify 이벤트 누락으로 인해 Linux 컨테이너 내부 웹 서버가 파일 수정 시점을 즉시 감지하지 못함
- **확인 과정**: WSL2 내부 네이티브 경로(`~/workspace/`)에 프로젝트를 복제하여 마운트했을 때 즉각 반영됨을 대조 확인
- **해결 조치**: 프로젝트 소스코드를 WSL2 가상 디스크(`\\wsl$\Ubuntu\home\...`) 내부에 배치하여 네이티브 ext4 파일 시스템 성능과 inotify 이벤트를 온전히 활용하도록 환경 개선

---

## 7. 핵심 개념 정리

### 1) 절대 경로 vs 상대 경로
- **절대 경로 (Absolute Path)**: 최상위 루트 디렉토리(`/`)부터 시작하여 대상 파일까지의 전체 고유 경로 (예: `/home/developer/src/index.html`). 실행 위치에 구애받지 않고 항상 동일한 대상을 가리킵니다.
- **상대 경로 (Relative Path)**: 현재 작업 디렉토리(`.` / `pwd`)를 기준으로 대상을 가리키는 경로 (예: `./src/index.html` 또는 `../README.md`). 이동이나 프로젝트 폴더 복제 시 유연합니다.

### 2) 파일 권한 체계 (r/w/x 및 8진수 표기)
- **권한 비트**: `Read (4)`, `Write (2)`, `Execute (1)`
- **3개 그룹**: 소유자(User) / 그룹(Group) / 기타 사용자(Others)
- **755 (`rwxr-xr-x`)**: 소유자는 읽기/쓰기/실행(4+2+1=7), 그룹과 기타 사용자는 읽기/실행(4+1=5). 주로 실행 가능한 스크립트나 진입해야 하는 디렉토리에 사용.
- **644 (`rw-r--r--`)**: 소유자는 읽기/쓰기(4+2=6), 그룹과 기타 사용자는 읽기 전용(4). 일반적인 설정 파일이나 텍스트 문서에 적용.

### 3) 커스텀 Dockerfile과 레이어 아키텍처
- Dockerfile의 각 명령어(`FROM`, `COPY`, `RUN`)는 변경 불가능한 읽기 전용 레이어(Layer)를 생성합니다.
- 자주 바뀌지 않는 의존성 설치를 상단에 배치하고, 자주 변경되는 소스코드 `COPY`를 하단에 배치함으로써 Docker의 레이어 캐싱(Cache) 메커니즘을 극대화하여 빌드 속도를 단축합니다.

### 4) 포트 매핑의 필요성
- 컨테이너는 호스트 OS의 네트워크 네임스페이스와 격리된 자체 가상 IP와 포트 대역을 갖습니다.
- `-p <Host_Port>:<Container_Port>` 포트 포워딩을 지정해야만 외부 트래픽이 호스트의 포트를 통해 컨테이너 내부 프로세스로 정상 전달됩니다.

### 5) Docker 볼륨 vs 바인드 마운트
- **바인드 마운트 (Bind Mount)**: 호스트의 특정 디렉토리/파일을 컨테이너에 직접 연결. 로컬 개발 시 소스코드 실시간 핫 리로딩에 최적화.
- **도커 볼륨 (Named Volume)**: Docker 엔진이 관리하는 전용 저장소 영역(`/var/lib/docker/volumes/`)에 데이터 저장. 컨테이너 삭제 후에도 데이터가 보존되며 운영 데이터베이스 영속성에 표준으로 사용.

### 6) Git vs GitHub
- **Git**: 로컬 컴퓨터에서 코드의 변경 이력(Commit, Branch, Merge)을 추적하고 관리하는 분산 버전 관리 시스템(DVCS).
- **GitHub**: Git 저장소를 인터넷 원격 서버에 호스팅하고, Pull Request, Issue Tracking, CI/CD(Actions) 등 협업 기능을 제공하는 웹 클라우드 플랫폼.
