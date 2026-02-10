---
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git branch:*), Bash(git log:*), Bash(gh pr create:*)
description: Create a draft pull request with auto-generated content based on git analysis
---
Hello Claude! I need you to create a **draft** pull request for the current branch.

## ⚠️ CRITICAL CONSTRAINT — MUST READ FIRST
- **PR은 반드시 Draft 모드로 생성해야 함. 예외 없음.**
- `gh pr create` 실행 시 반드시 `--draft` 플래그를 포함할 것.
- `--draft` 플래그 없이 `gh pr create`를 실행하는 것은 **절대 금지**.
- Draft가 아닌 일반 PR이 생성되면 리뷰어에게 즉시 알림이 가서 혼란을 유발함.

## Requirements
- **반드시 `--draft` 플래그와 함께 PR 생성 (NON-NEGOTIABLE)**
- **Write all PR content in Korean (한국어로 작성)**
- Analyze current git status and changes comprehensively
- Auto-generate meaningful PR title and description
- Use appropriate conventional commit categories
- Ensure the branch is up-to-date with main/master before creating PR

## Language Guidelines (언어 가이드라인)
- **PR 제목과 본문을 모두 한국어로 작성**
- 기술적 용어는 영어 그대로 사용해도 됨 (예: API, Database, Component)
- 존댓말 대신 간결한 서술형 문체 사용
- 개발팀이 이해하기 쉬운 명확한 표현 사용

## Analysis Process
1. **Git Status Analysis**
   - Check current branch: `git branch --show-current`
   - Review staged/unstaged changes: `git status`
   - Compare with remote main: `git diff HEAD main` (or master)
   - Verify branch is based on latest main/master

2. **Change Categorization**
   - 새로운 기능 (feat)
   - 버그 수정 (fix)  
   - 문서 변경 (docs)
   - 코드 스타일 업데이트 (style)
   - 리팩토링 (refactor)
   - 테스트 (test)
   - 빌드/설정 변경 (chore)

3. **Content Generation**
   - Analyze file changes and commit messages
   - Extract key patterns and impact
   - Generate smart PR title with appropriate emoji
   - Create comprehensive description following the Korean template

## PR Description Template (한국어)
Use this Korean structure for the pull request body:
```markdown
## 변경사항 요약
[Git 분석을 기반으로 자동 생성된 요약]

## 변경 이유  
[커밋 메시지와 파일 변경사항에서 추론]

## 주요 변경내용
[수정된 파일을 기반으로 자동 생성된 체크리스트]
- [ ] [컴포넌트/모듈명] - 변경사항 설명
- [ ] [API/Database] - 변경사항 설명
- [ ] [문서] - 변경사항 설명

## 테스트
[테스트 파일을 자동 감지하고 테스트 방법 제안]
- [ ] 단위 테스트 통과
- [ ] 통합 테스트 확인  
- [ ] 수동 테스트 완료

## 스크린샷 (해당되는 경우)
[UI 관련 파일이 수정된 경우 이 섹션 포함]

## 주의사항
[변경사항 분석을 기반으로 자동 생성]
- 호환성을 깨뜨리는 변경사항 감지됨
- 마이그레이션 단계 필요
- 성능에 미치는 영향
- 보안 고려사항

## 관련 이슈
[커밋 메시지에서 이슈 번호 추출 (있는 경우)]
Closes #issue-number
```

## Execution (실행)
**반드시 아래 형식으로 실행할 것. `--draft` 누락 금지.**

```bash
gh pr create --draft --title "PR 제목" --body "$(cat <<'EOF'
... PR 본문 ...
EOF
)"
```

- `--draft` 플래그가 빠진 `gh pr create` 명령은 실행하지 말 것.
- 만약 `--draft` 없이 실행하려는 자신을 발견하면, 즉시 멈추고 `--draft`를 추가할 것.
