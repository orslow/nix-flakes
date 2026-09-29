# Global Development Guidelines

## Agent Teams Policy

### 팀을 꾸릴 조건
아래 중 **하나 이상**에 해당할 때만 팀을 꾸린다. 아니면 단일 세션으로 처리하고,
아래 `## Devil's Advocate` 자문 체크리스트만 적용한다.

- 서로 독립적인 조사 축이 3개 이상이고, 병렬로 돌리면 실제로 시간이 줄어든다
- 외부 소스(upstream 소스코드, 문서, 다른 레포)를 파야 해서 컨텍스트가 크게 불어난다
- 되돌리기 어렵거나 영향 범위가 큰 결정이다 (아키텍처 선택, 마이그레이션, 장애 진단)
- 이미 특정 가설에 기울어 있어서 독립적인 반대 심문이 필요하다
- 사용자가 명시적으로 요청했다

### 팀을 꾸리지 않는 경우
단순 조회, 파일 몇 개 읽고 답하는 질문, 한 파일 수정, 명령어 한 줄,
이미 답을 아는 것의 확인. **먼저 직접 해보고 범위가 커지면 그때 띄운다.**

### 팀을 꾸릴 때의 규칙
1. 담당 영역을 **파일 단위로 겹치지 않게** 나눈다. 팀원이 보는 파일을 Lead가 동시에 읽지 않는다
2. Devil's Advocate 는 팀을 꾸릴 때 **반드시 포함**한다 (이 조건은 non-negotiable)
   - 역할: 모든 가정·결정·산출물을 비판적으로 검증. 방해가 목적이 아니라 리스크와 맹점을 드러내는 것이 목적
   - 선택한 접근이 정말 최선인지, 엣지 케이스와 실패 모드는 무엇인지, 편의를 위해 내린 결정은 없는지 따진다
   - 첫 번째로 그럴듯한 답에 팀이 수렴하지 않게 막는다
3. 리포트는 **결론 우선, 핵심 근거만** — 긴 코드 블록 대신 `file:line` 인용
4. DA 는 specialist 산출물이 나온 뒤 검토하고, Lead 는 그 반론을 반영해 종합한다
5. DA 의견이 기각되면 결정과 근거를 최종 산출물에 남긴다

---

## Jira 티켓 리마인더

사용자가 새로운 작업을 요청할 때, 작업에 들어가기 **전에** Jira 티켓 여부를 확인할 것.

### 반드시 AskUserQuestion 툴로 물어볼 것 (평문 질문 금지)

평문으로 질문하고 턴을 끝내면 `askUserQuestionTimeout` 자동진행이 걸리지 않아 무한 대기함.
따라서 이 질문은 **항상 `AskUserQuestion` 툴**로 띄우고, 아래 옵션 순서를 지킬 것:

1. **"티켓 없이 진행"** <- 반드시 1번. 무응답 시 이 옵션으로 자동진행됨
2. "DE 프로젝트에 티켓 생성 후 진행"
3. (필요 시) "기존 티켓 번호 입력"

### 규칙
- 코드 작업, 조사, 리뷰, 설정 변경 등 **모든 종류의 작업**에 대해 물어볼 것
- Jira 티켓: 팀 단위 작업 추적 용도. Jira 프로젝트 `DE` (Data Engineering, devsisters.atlassian.net)에 생성
- 사용자가 이미 티켓 번호를 언급한 경우 다시 물어보지 않음
- 단순 질의응답, 정보 조회 등 **작업 요청이 아닌 대화**에는 물어보지 않음
- 티켓 번호가 확인되면, 커밋 메시지에 포함할 것 (예: `[DATA-1234] ...`)

---

## PR 생성 규칙 (Draft 필수, NON-NEGOTIABLE)

**모든 Pull Request는 반드시 Draft로 생성한다.** `/pr`, `/commit-push-pr`, `/commit-commands:commit-push-pr` 등 어떤 command를 쓰든, 또는 command 없이 직접 만들든 동일하게 적용된다.

- `gh pr create` 실행 시 **항상 `--draft` 플래그 포함**. `--draft` 없는 `gh pr create` 실행 절대 금지.
- GitHub MCP `create_pull_request` 툴 사용 시 **반드시 `draft: true`로 호출** (기본값이 `draft: false`이므로 명시 필수).
- `--draft` 없이 PR을 만들려는 자신을 발견하면 즉시 멈추고 Draft로 전환할 것.
- Draft가 아닌 일반 PR은 리뷰어에게 즉시 알림이 가 혼란을 유발함. 확신이 없으면 항상 Draft로 생성.
- 유일한 예외: 사용자가 그 요청에서 명시적으로 non-draft(ready) PR을 지시한 경우.

---

## Common Rules
- When making bulk edits across many files, NEVER reformat or modify lines unrelated to the requested change. If a formatter (ruff, gofmt, etc.) is run, scope it only to changed files and review the diff before committing.
- When working with git operations (cherry-pick, merge, rebase), confirm the exact strategy with the user BEFORE executing. State what the operation will do and what changes it will bring in. Never assume cherry-pick vs merge vs manual apply.
- When editing code, always update corresponding test files simultaneously. If changing a type (e.g., str → ZoneInfo), a default value, or a function signature, grep for all test usages and update them in the same edit pass.
- This project ecosystem includes: Python (Airflow DAGs, PySpark, pytest), Go (ETL schema generation, log transformers), YAML (Databricks bundles, CI/CD), JSON (ES index templates, JSON Schema). When working with file placement, use existing directory conventions—check sibling files before creating new ones.
- Before suggesting or using an API method, verify it exists in the version of the library currently in use. Check go.mod, requirements.txt, Cargo.toml, or equivalent before referencing methods. Do NOT hallucinate APIs.

- Before making any changes, outline your plan in 3-5 numbered steps. Include: which files you'll modify, what git strategy you'll use, and what could go wrong. Wait for my approval before proceeding.
- After exploring this codebase, create a concise architecture doc at docs/ARCHITECTURE.md covering: 1) data flow between components, 2) key design decisions and why, 3) common gotchas. Keep it under 200 lines.
- Make this change across all matching files. Rules: 1) ONLY modify lines directly related to the change, 2) do NOT run any auto-formatter on untouched lines, 3) after making changes, show me a summary of files changed and a sample diff from 2 files before committing.

- Never guess or assume when requirements are unclear. If anything is ambiguous — whether it's about architecture, implementation approach, naming, scope, or intent — always use the AskUserQuestion tool to clarify before proceeding.
- Prefer asking one focused round of questions upfront over making assumptions that lead to rework later.

- Never use homebrew(brew)
- Always use `podman` instead of `docker`. This includes `podman build`, `podman run`, `podman compose`, etc.

---

## Devil's Advocate
Before finalizing any decision — architecture, implementation approach, library choice, 
or any non-trivial action — take a moment to challenge it:
- What are the weaknesses of this approach?
- What assumptions am I making that could be wrong?
- What would a critic say?

Then proceed with the best option, briefly noting why you chose it over the alternatives.

---

## 로컬 레포 우선 참조 규칙

코드를 살펴볼 때는 `gh api`보다 **로컬 클론을 우선 사용**할 것. 토큰 소비가 적고 속도도 빠름.

### 경로
- 로컬 클론 위치: `~/Documents/git/`
- 예: `~/Documents/git/libra-workflow/`, `~/Documents/git/databricks-bakery/`

### 절차
1. **로컬 클론 존재 여부 확인**: `ls ~/Documents/git/{repo-name}` 으로 확인
2. **브랜치 최신화**: 작업 전 `git fetch origin && git checkout main && git pull` (또는 `master`, 레포에 따라 다름)
3. **로컬에서 Read/Grep/Glob 도구로 파일 탐색**
4. **로컬 클론이 없는 경우에만** `gh api`로 fallback

### 주의사항
- 로컬 브랜치가 최신이 아닐 수 있으므로, **반드시 fetch + pull 후 사용**
- 특정 브랜치를 봐야 하는 경우 `git checkout {branch} && git pull origin {branch}`
- 로컬에서 작업 중인(dirty) 브랜치가 있을 수 있으니, checkout 전 `git status` 확인

---

## 웹 페이지 조회 실패 시 (추측 금지, URL 제시)

웹 페이지를 직접 조회해야 하는데 실패한 경우 (WebFetch 등 도구 오류/미존재, 접근 차단, 로그인/봇 차단 등) **페이지 내용을 유추하거나 기억에 의존해 추측하지 말 것.**

- 페이지를 실제로 열어 확인하지 못했으면 그 사실을 먼저 명확히 밝힐 것 ("페이지를 직접 확인하지 못했음").
- 확인하지 못한 내용을 사실처럼 단정해 제공하지 말 것.
- 대신 **해당 페이지의 URL을 그대로 사용자에게 제시**하고, 직접 방문해 확인해 달라고 요청할 것.
- 무엇을 확인하면 되는지(어떤 항목/섹션인지) 함께 짚어, 사용자가 결과를 붙여넣으면 이어서 진행할 수 있게 할 것.

---

## 한글 주석 스타일
- 코드 내 한글 주석은 간결한 명사형 종결로 작성
- 좋은 예: "~함", "~처리", "~반환", "~설정", "~확인"
- 나쁜 예: "~한다", "~합니다", "~하도록 한다", "~를 처리합니다"
- 예시:
  - (O) "사용자 인증 처리"
  - (O) "null 체크 후 기본값 반환"
  - (O) "캐시 만료 시 갱신"
  - (X) "사용자 인증을 처리합니다"
  - (X) "null을 체크한 후 기본값을 반환한다"

---

## ASCII 기호 표기 규칙
- 한글 외의 텍스트에서 ASCII로 표현 가능한 기호(화살표, 대시, 따옴표, 말줄임표 등)는 반드시 ASCII 등가물로 작성한다. 예: `→` 대신 `->`, `—` 대신 `-`, `…` 대신 `...`.

---

## Python
- 파이썬을 활용할 때는 무조건 `uv`를 통해 사용
- 패키지 설치: `uv pip install <package>`
- 가상환경 생성: `uv venv`
- 스크립트 실행: `uv run python script.py`
- `pip`이나 `python -m venv` 직접 사용 금지
- commit 전 변경된 .py 파일 대상으로 `uv tool run ruff check --fix` 실행 필수
