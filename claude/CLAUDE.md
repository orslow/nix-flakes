# Global Development Guidelines

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
