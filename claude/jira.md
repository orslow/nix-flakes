---
allowed-tools: mcp__plugin_atlassian_atlassian__createJiraIssue, mcp__plugin_atlassian_atlassian__searchJiraIssuesUsingJql, mcp__plugin_atlassian_atlassian__getJiraIssue, mcp__plugin_atlassian_atlassian__editJiraIssue, mcp__plugin_atlassian_atlassian__getVisibleJiraProjects, mcp__plugin_atlassian_atlassian__getJiraProjectIssueTypesMetadata, mcp__plugin_atlassian_atlassian__getAccessibleAtlassianResources, mcp__plugin_atlassian_atlassian__atlassianUserInfo
description: Create a Jira issue in Data Platform project
---
Hello Claude! I need you to create a Jira issue.

## Default Configuration
- **Default Project**: Data Platform (DP)
- 프로젝트를 명시하지 않으면 기본적으로 **Data Platform** 프로젝트 사용 (Data Intelligence 가 있어서 헷갈릴 수 있는데 Data Intelligence 가 아님!)

## Requirements
- **나에게 할당**: `atlassianUserInfo` 도구로 현재 사용자 account_id 조회 후 할당
- **현재 스프린트에 할당**: Sprint 필드 설정
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
   - 프로젝트 키 확인 (기본: DP)

3. **현재 스프린트 확인**
   - JQL로 현재 활성 스프린트 확인: `project = DP AND sprint in openSprints()`
   - 스프린트 ID 추출

4. **이슈 생성**
   - `createJiraIssue` 도구 사용
   - 필수 필드:
     - cloudId: 조회한 값
     - projectKey: DP (또는 사용자 지정)
     - issueTypeName: 작업 (또는 사용자 지정)
     - summary: 사용자 입력
     - assignee_account_id: 조회한 현재 사용자 ID
   - 선택 필드:
     - description: 상세 설명
     - additional_fields: 스프린트 등

## Sprint Assignment
현재 스프린트에 할당하려면 `additional_fields`에 Sprint 필드 추가.
Sprint 필드 ID는 프로젝트마다 다를 수 있으므로 필요시 메타데이터 조회.

## Example Usage
사용자: "로그 수집 파이프라인 최적화 작업 만들어줘"

→ 생성될 이슈:
- Project: DP
- Type: 작업
- Summary: 로그 수집 파이프라인 최적화
- Assignee: 현재 사용자 (나)
- Sprint: 현재 활성 스프린트

## Your Task
사용자의 요청을 분석하여 적절한 Jira 이슈를 생성해줘. 생성 후 이슈 키와 링크를 알려줘.
