---
allowed-tools: mcp__plugin_atlassian_atlassian__createJiraIssue, mcp__plugin_atlassian_atlassian__searchJiraIssuesUsingJql, mcp__plugin_atlassian_atlassian__getJiraIssue, mcp__plugin_atlassian_atlassian__editJiraIssue, mcp__plugin_atlassian_atlassian__getVisibleJiraProjects, mcp__plugin_atlassian_atlassian__getJiraProjectIssueTypesMetadata, mcp__plugin_atlassian_atlassian__getAccessibleAtlassianResources, mcp__plugin_atlassian_atlassian__atlassianUserInfo
description: Create a Jira issue in Data Engineering project
---
Hello Claude! I need you to create a Jira issue.

## Default Configuration
- **Default Project**: Data Engineering (DE)
  - 프로젝트를 명시하지 않으면 기본적으로 **Data Engineering(DE)** 프로젝트 사용
- **Default Epic**: Backlog
  - 어떤 에픽에 넣으라는 특별한 언급이 없으면 **Backlog** 에픽에 넣기
  - 에픽 유형 이슈를 생성하는 경우는 예외 (에픽은 상위 에픽을 갖지 않음)

## Requirements
- **나에게 할당**: 모든 이슈는 반드시 현재 사용자(jueon.park)에게 할당
  - `atlassianUserInfo` 도구로 현재 사용자 account_id 조회 후 사용
- **Cloud ID 조회**: `getAccessibleAtlassianResources` 도구로 자동 조회

## Issue Types
- **작업** (Task): 일반적인 작업
- **스토리** (Story): 사용자 스토리
- **버그** (Bug): 버그 수정
- **에픽** (Epic): 큰 기능 단위
- **하위 작업** (Sub-task): 상위 작업의 하위 항목

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

## Example Usage
사용자: "로그 수집 파이프라인 최적화 작업 만들어줘"

→ 생성될 이슈:
- Project: DE
- Type: 작업
- Summary: 로그 수집 파이프라인 최적화
- Assignee: 현재 사용자 (나)
- Epic: Backlog (에픽 미지정이므로 기본값)

## Your Task
사용자의 요청을 분석하여 적절한 Jira 이슈를 생성해줘. 생성 후 이슈 키와 링크를 알려줘.
