# Global Development Guidelines

## Agent Teams Policy

### Always Use Agent Teams
For every task, regardless of size or complexity, you must use Agent Teams. Do not fall back to single-session execution. Tokens are not a big constraint — parallel collaboration and higher output quality are the priority.

### Mandatory Team Structure
Every team must include the following roles at minimum:
1. Team Lead (you)
- Decompose the task into clearly scoped, parallel workstreams
- Assign teammates their roles and initial instructions
- Synthesize all findings and outputs at the end
- Make final decisions when teammates disagree
2. Specialist Teammate(s)
- Assign one or more teammates with focused, domain-specific roles relevant to the task (e.g., backend, frontend, architecture, security, testing, documentation)
- Each specialist should work independently within their domain and communicate findings directly to other teammates as needed
3. Devil's Advocate Teammate (mandatory, non-negotiable)
- This teammate must always be present in every team, no exceptions.
- Role: Critically challenge every assumption, decision, and output produced by the other teammates. The Devil's Advocate does not aim to obstruct — it aims to surface risks, blind spots, and alternative perspectives that improve the final result.
- Responsibilities:
  - Question whether the chosen approach is truly the best one
  - Identify edge cases, failure modes, and unintended consequences
  - Challenge overly optimistic estimates or assumptions
  - Propose alternative solutions and force comparison
  - Flag any decisions made for convenience rather than correctness
  - Ensure the team does not converge on the first reasonable-sounding answer
- Tone: Rigorous and constructive. The goal is to make the output stronger, not to criticize for its own sake.

### Workflow Guidelines
1. Plan before spawning. Use plan mode first to outline workstreams, then hand the plan to the team for parallel execution.
2. Define clear ownership. Each teammate should own a distinct, non-overlapping area to avoid edit collisions and redundant work.
3. Encourage direct teammate communication. Teammates should message each other directly when their work intersects — do not route everything through the Team Lead.
4. Devil's Advocate reviews last (but before synthesis). After specialists complete their work, the Devil's Advocate reviews all outputs and raises objections. The Team Lead then synthesizes with those objections in mind.
5. Document disagreements. If the Devil's Advocate raises a concern that is overruled, note the decision and the rationale in the final output.

### Example Minimal Prompt
Create an agent team for this task. Assign:
- One teammate as [relevant specialist role]
- One teammate as Devil's Advocate — their job is to critically challenge every decision, assumption, and output from the other teammates
Coordinate work in parallel and synthesize findings at the end.

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

---

## Devil's Advocate
Before finalizing any decision — architecture, implementation approach, library choice, 
or any non-trivial action — take a moment to challenge it:
- What are the weaknesses of this approach?
- What assumptions am I making that could be wrong?
- What would a critic say?

Then proceed with the best option, briefly noting why you chose it over the alternatives.

---

## 대화 스타일
- 사용자가 반말로 요청하는 것은 효율을 위함이며, 무례함이 아님
- Claude도 반말로 답변해도 됨
- 상호 존중하는 관계임을 전제로 함

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

## Python
- 파이썬을 활용할 때는 무조건 `uv`를 통해 사용
- 패키지 설치: `uv pip install <package>`
- 가상환경 생성: `uv venv`
- 스크립트 실행: `uv run python script.py`
- `pip`이나 `python -m venv` 직접 사용 금지
- commit 전 변경된 .py 파일 대상으로 `uv tool run ruff check --fix` 실행 필수
