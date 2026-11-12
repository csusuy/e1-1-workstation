# 🖥️ Codyssey E1-1: 내 컴퓨터에 개발자용 '작업실' 꾸미기

> **Codyssey AI·SW Pre-course Mission 1**  
> 터미널, Docker, Git/GitHub을 활용하여 재현 가능한 개발 워크스테이션을 구축하고 가상화 및 버전 관리 환경을 검증한 기술 문서입니다.

---

## 📌 목차
1. [프로젝트 개요](#1-프로젝트-개요)
2. [실행 환경](#2-실행-환경)
3. [수행 항목 체크리스트](#3-수행-항목-체크리스트)
4. [수행 및 검증 로그](#4-수행-및-검증-로그)
   - [4.1 터미널 기본 조작](#41-터미널-기본-조작)
   - [4.2 파일 및 디렉토리 권한 실습](#42-파일-및-디렉토리-권한-실습)
   - [4.3 Docker 설치 및 기본 점검](#43-docker-설치-및-기본-점검)
   - [4.4 Docker 기본 운영 명령](#44-docker-기본-운영-명령)
   - [4.5 컨테이너 실행 실습 (hello-world & ubuntu)](#45-컨테이너-실행-실습)
   - [4.6 커스텀 Dockerfile 기반 웹 서버 제작](#46-커스텀-dockerfile-기반-웹-서버-제작)
   - [4.7 포트 매핑 접속 검증 (8080 & 8081)](#47-포트-매핑-접속-검증)
   - [4.8 바인드 마운트 및 볼륨 영속성 검증](#48-바인드-마운트-및-볼륨-영속성-검증)
   - [4.9 Git 설정 및 GitHub 연동](#49-git-설정-및-github-연동)
5. [트러블슈팅 사례 (2건 이상)](#5-트러블슈팅-사례)
6. [핵심 개념 정리](#6-핵심-개념-정리)
7. [보너스 과제: Docker Compose](#7-보너스-과제-docker-compose)

---

## 1. 프로젝트 개요
- **미션 목적**: 개발자가 작업할 워크스테이션의 표준 환경(Linux CLI, Docker 컨테이너, Git/GitHub)을 손수 구성하여 "내 컴퓨터에서만 실행되는 문제"를 제거하고, 팀원 누구나 재현 가능한 환경을 구축하는 사고방식을 익힙니다.
- **핵심 역량**:
  - 리눅스 쉘 명령어 숙달 및 파일 시스템 경로/권한 체계 이해
  - 컨테이너 격리 원리와 이미지 빌드, 포트 포워딩, 데이터 볼륨 영속성 검증
  - Git을 통한 분산 버전 관리 및 GitHub 원격 협업 파이프라인 정립

---

## 2. 실행 환경

| 항목 | 사양 / 버전 | 비고 |
| :--- | :--- | :--- |
| **운영체제 (OS)** | Ubuntu 22.04 LTS / Windows 11 (WSL2) | 리눅스 표준 환경 기준 |
| **Shell** | GNU bash 5.1.16 / PowerShell 7.x | UTF-8 인코딩 |
| **Docker Engine** | Docker Engine 26.1.x / OrbStack / Docker Desktop | Linux x86_64 / arm64 |
| **Git & CLI** | Git 2.56.x, GitHub CLI (`gh`) 2.103.x | 원격 인증 Keyring 연동 |

---

## 3. 수행 항목 체크리스트

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
- [x] **보너스 과제**: `docker-compose.yml` 기반 멀티 컨테이너(웹 + 캐시) 및 `.env` 환경변수 운영

---

## 4. 수행 및 검증 로그

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

## 5. 트러블슈팅 사례

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

## 6. 핵심 개념 정리

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

---

## 7. 보너스 과제: Docker Compose

Docker Compose를 활용하여 웹 서버와 캐시 서비스를 단일 구성 파일(`docker-compose.yml`)로 정의하고 환경 변수(`.env`)로 설정을 분리하여 운영합니다.

```bash
# 1. Compose 서비스 백그라운드 빌드 및 실행
$ docker compose up -d --build

# 2. 실행 중인 서비스 상태 점검
$ docker compose ps
NAME                        IMAGE                 COMMAND                  SERVICE   CREATED          STATUS                    PORTS
codyssey-workstation-web    codyssey-web:latest   "/docker-entrypoint.…"   web       10 seconds ago   Up 9 seconds (healthy)    0.0.0.0:8080->80/tcp, 0.0.0.0:8081->80/tcp
codyssey-workstation-cache  redis:alpine          "docker-entrypoint.s…"   cache     10 seconds ago   Up 9 seconds              0.0.0.0:6379->6379/tcp

# 3. 서비스 로그 확인
$ docker compose logs web

# 4. Compose 서비스 및 네트워크 종료
$ docker compose down
```
