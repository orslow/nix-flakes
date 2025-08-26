---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
description: Create a git commit
---

Hello Claude! I need you to commit the currently staged changes in this repository.

## Requirements

- Review the staged changes first using `git status` and `git diff --cached`
- Write a clear, descriptive commit message following conventional commit format
- **Must use appropriate conventional commit prefixes** such as:
  - `feat:` - for new features
  - `fix:` - for bug fixes
  - `docs:` - for documentation changes
  - `style:` - for formatting changes
  - `refactor:` - for code refactoring
  - `test:` - for adding/updating tests
  - `chore:` - for maintenance tasks
- The commit message should:
  - Be concise but informative
  - Use present tense (e.g., "Add feature" not "Added feature")
  - Follow the format: `prefix: description` or `prefix(scope): description`
  - Include more details in the body if necessary

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

## Your task

- Based on the above changes, create a single git commit.
- Please perform a git commit with the staged files using an appropriate commit message with conventional commit prefixes.

