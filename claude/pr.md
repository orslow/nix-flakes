---
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git branch:*), Bash(git log:*), Bash(gh pr create:*)
description: Create a draft pull request with auto-generated content based on git analysis
---

Hello Claude! I need you to create a draft pull request for the current branch.

## Requirements
- **Always create PRs in draft mode**
- Analyze current git status and changes comprehensively
- Auto-generate meaningful PR title and description
- Use appropriate emoji prefixes and conventional commit categories
- Ensure the branch is up-to-date with main/master before creating PR

## Analysis Process
1. **Git Status Analysis**
   - Check current branch: `git branch --show-current`
   - Review staged/unstaged changes: `git status`
   - Compare with remote main: `git diff HEAD main` (or master)
   - Verify branch is based on latest main/master
   
2. **Change Categorization**
   - 🆕 New features (feat)
   - 🐛 Bug fixes (fix)  
   - 📚 Documentation changes (docs)
   - 🎨 Code style updates (style)
   - ♻️ Refactoring (refactor)
   - ✅ Testing (test)
   - 🔧 Build/config changes (chore)

3. **Content Generation**
   - Analyze file changes and commit messages
   - Extract key patterns and impact
   - Generate smart PR title with appropriate emoji
   - Create comprehensive description following the template

## PR Description Template
Use this structure for the pull request body:

```markdown
## 📝 Summary of Changes
[Auto-generated summary based on git analysis]

## 🎯 Reason for Changes  
[Inferred from commit messages and file changes]

## 🔧 Key Changes
[Automatically populated checklist based on modified files]
- [ ] [Component/Module] - Description of change
- [ ] [API/Database] - Description of change
- [ ] [Documentation] - Description of change

## 🧪 Testing
[Auto-detect test files and suggest testing approach]
- [ ] Unit tests pass
- [ ] Integration tests verified  
- [ ] Manual testing completed

## 📷 Screenshots (if applicable)
[Include this section if UI-related files were modified]

## ⚠️ Important Notes
[Auto-generated based on change analysis]
- Breaking changes detected
- Migration steps required
- Performance implications
- Security considerations

## 🔗 Related Issues
[Extract issue numbers from commit messages if present]
Closes #issue-number
```

## Context Commands
Execute these commands to gather context:
- Current branch: `git branch --show-current`
- Git status: `git status`
- Changes since main: `git diff HEAD main`
- Recent commits: `git log --oneline -10`
- Remote status: `git fetch && git status`

## Your Task
1. Execute the context commands to analyze the current state
2. Generate appropriate PR title and description using the template
3. Create a draft pull request using: `gh pr create --draft --title "[TITLE]" --body "[DESCRIPTION]"`
4. Ensure the PR includes all necessary sections based on the type of changes detected
