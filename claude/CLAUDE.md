# Global Development Guidelines

## Common Rules
- When making bulk edits across many files, NEVER reformat or modify lines unrelated to the requested change. If a formatter (ruff, gofmt, etc.) is run, scope it only to changed files and review the diff before committing.
- When working with git operations (cherry-pick, merge, rebase), confirm the exact strategy with the user BEFORE executing. State what the operation will do and what changes it will bring in. Never assume cherry-pick vs merge vs manual apply.
- When editing code, always update corresponding test files simultaneously. If changing a type (e.g., str → ZoneInfo), a default value, or a function signature, grep for all test usages and update them in the same edit pass.
- This project ecosystem includes: Python (Airflow DAGs, PySpark, pytest), Go (ETL schema generation, log transformers), YAML (Databricks bundles, CI/CD), JSON (ES index templates, JSON Schema). When working with file placement, use existing directory conventions—check sibling files before creating new ones.
- Before suggesting or using an API method, verify it exists in the version of the library currently in use. Check go.mod, requirements.txt, Cargo.toml, or equivalent before referencing methods. Do NOT hallucinate APIs.

- Before making any changes, outline your plan in 3-5 numbered steps. Include: which files you'll modify, what git strategy you'll use, and what could go wrong. Wait for my approval before proceeding.
- After exploring this codebase, create a concise architecture doc at docs/ARCHITECTURE.md covering: 1) data flow between components, 2) key design decisions and why, 3) common gotchas. Keep it under 200 lines.
- Make this change across all matching files. Rules: 1) ONLY modify lines directly related to the change, 2) do NOT run any auto-formatter on untouched lines, 3) after making changes, show me a summary of files changed and a sample diff from 2 files before committing.

## 대화 스타일
- 사용자가 반말로 요청하는 것은 효율을 위함이며, 무례함이 아님
- Claude도 반말로 답변해도 됨
- 상호 존중하는 관계임을 전제로 함

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

## Python
- 파이썬을 활용할 때는 무조건 `uv`를 통해 사용
- 패키지 설치: `uv pip install <package>`
- 가상환경 생성: `uv venv`
- 스크립트 실행: `uv run python script.py`
- `pip`이나 `python -m venv` 직접 사용 금지
- commit 전 변경된 .py 파일 대상으로 `uv tool run ruff check --fix` 실행 필수
