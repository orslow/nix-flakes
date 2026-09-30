---
allowed-tools: mcp__plugin_atlassian_atlassian__createJiraIssue, mcp__plugin_atlassian_atlassian__searchJiraIssuesUsingJql, mcp__plugin_atlassian_atlassian__getJiraIssue, mcp__plugin_atlassian_atlassian__editJiraIssue, mcp__plugin_atlassian_atlassian__getVisibleJiraProjects, mcp__plugin_atlassian_atlassian__getJiraProjectIssueTypesMetadata, mcp__plugin_atlassian_atlassian__getAccessibleAtlassianResources, mcp__plugin_atlassian_atlassian__atlassianUserInfo, mcp__github__issue_write, mcp__github__list_issue_types, Bash(gh issue create:*)
description: Create a Jira issue in Data Engineering project and a mirrored GitHub issue
---
Hello Claude! I need you to create a Jira issue **and a mirrored GitHub issue with the same content**.

## Default Configuration
- **Default Project**: Data Engineering (DE)
  - 프로젝트를 명시하지 않으면 기본적으로 **Data Engineering(DE)** 프로젝트 사용
- **Default Epic**: Backlog
  - 어떤 에픽에 넣으라는 특별한 언급이 없으면 **Backlog** 에픽에 넣기
  - 에픽 유형 이슈를 생성하는 경우는 예외 (에픽은 상위 에픽을 갖지 않음)
- **Mirror Repo**: `devsisters/data-engineering-issues` (private)
  - Jira 티켓과 **같은 내용**으로 GitHub 이슈도 생성
  - 두 이슈는 서로 링크하지 않음 (각각 독립)

## Requirements
- **나에게 할당**: 모든 이슈는 반드시 현재 사용자(jueon.park)에게 할당
  - `atlassianUserInfo` 도구로 현재 사용자 account_id 조회 후 사용
- **Cloud ID 조회**: `getAccessibleAtlassianResources` 도구로 자동 조회
- **GitHub 이슈 기본값**:
  - assignees: `orslow` (현재 사용자)
  - labels: `priority/medium` (사용자가 우선순위를 명시하면 `priority/high` / `priority/low`)
  - type: Jira 유형에 대응 (아래 매핑 표 참조)
- **본문 길이**: Jira/GitHub 모두 본문은 **5줄 이내**로 간결하게 (전역 CLAUDE.md 규칙)

## Issue Types
- **작업** (Task): 일반적인 작업
- **스토리** (Story): 사용자 스토리
- **버그** (Bug): 버그 수정
- **에픽** (Epic): 큰 기능 단위
- **하위 작업** (Sub-task): 상위 작업의 하위 항목

### Jira -> GitHub 유형 매핑
| Jira | GitHub issue type |
|---|---|
| 작업 (Task) | `Task` |
| 버그 (Bug) | `Bug` |
| 스토리 (Story) | `Feature` |
| 에픽 / 하위 작업 | 유형 생략 (대응값 없음) |

## Process
1. **환경 정보 조회**
   - `getAccessibleAtlassianResources`로 Cloud ID 조회
   - `atlassianUserInfo`로 현재 사용자 account_id 조회

2. **사용자 입력 분석**
   - 이슈 제목 (summary) 추출
   - 이슈 유형 판단 (기본: 작업)
   - 설명 (description) 추출 (있는 경우)
   - 프로젝트 키 확인 (기본: DE)
   - 상위 에픽 확인 (기본: Backlog)

3. **상위 에픽 키 조회**
   - 사용자가 에픽을 명시하지 않았으면 Backlog 에픽 사용
   - `searchJiraIssuesUsingJql`로 키 조회:
     `project = DE AND issuetype = 에픽 AND summary ~ "Backlog"`
   - 조회 결과가 없으면 에픽 연결 없이 생성 후 사용자에게 알림

4. **이슈 생성**
   - `createJiraIssue` 도구 사용
   - 필수 필드 (하나라도 빠지면 안 됨):
     - cloudId: 조회한 값
     - projectKey: DE (또는 사용자 지정)
     - issueTypeName: 작업 (또는 사용자 지정)
     - summary: 사용자 입력
   - 선택 필드:
     - description: 상세 설명
     - additional_fields: 상위 에픽(`parent`), 스프린트 등
       - 상위 에픽 연결: `parent` 에 조회한 에픽 키 지정 (예: `{"parent": {"key": "DE-123"}}`)
       - 생성 시 `parent` 가 거부되면 `editJiraIssue` 로 생성 후 연결
   - **호출 직전 체크리스트**: `assignee_account_id` 파라미터가 포함되어 있는가? 없다면 추가 후 호출

5. **GitHub 이슈 생성** (Jira 생성 성공 후)
   - `mcp__github__issue_write` 사용 (`method: "create"`)
     - owner: `devsisters`, repo: `data-engineering-issues`
     - title: Jira summary와 **동일**
     - body: Jira description과 **동일** (5줄 이내)
     - assignees: `["orslow"]`
     - labels: `["priority/medium"]` (또는 사용자 지정 우선순위)
     - type: 매핑 표에 따라 `Task` / `Bug` / `Feature`
   - MCP 툴이 실패하면 `gh issue create` 로 폴백:
     ```
     gh issue create --repo devsisters/data-engineering-issues \
       --title "<제목>" --body "<본문>" --assignee orslow --label priority/medium
     ```
   - **GitHub 이슈 생성이 실패해도 Jira 티켓은 되돌리지 않음.**
     실패 사실과 위 수동 생성 명령어를 사용자에게 안내할 것

## Example Usage
사용자: "로그 수집 파이프라인 최적화 작업 만들어줘"

→ Jira 티켓:
- Project: DE
- Type: 작업
- Summary: 로그 수집 파이프라인 최적화
- Assignee: 현재 사용자 (나)
- Epic: Backlog (에픽 미지정이므로 기본값)

→ GitHub 이슈 (`devsisters/data-engineering-issues`):
- Title: 로그 수집 파이프라인 최적화 (Jira와 동일)
- Type: Task
- Assignee: orslow
- Label: priority/medium

## Your Task
사용자의 요청을 분석하여 Jira 티켓을 만들고, 이어서 같은 내용으로 GitHub 이슈도 생성해줘.
완료 후 **Jira 이슈 키 + 링크**와 **GitHub 이슈 번호 + 링크**를 함께 알려줘.
