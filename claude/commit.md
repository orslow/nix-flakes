---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git branch:*), Bash(git checkout:*), Bash(git switch:*)
description: Create a git commit
---
Hello Claude! I need you to commit the currently staged changes in this repository.

## Requirements
- **First, check if currently on a main/default branch** using `git branch --show-current`
- **If on main/master/develop or default branch, create and switch to a new feature branch first**
  - Use descriptive branch names like `feature/add-login`, `fix/header-bug`, `docs/update-readme`, etc.
  - Create branch with: `git checkout -b <branch-name>` or `git switch -c <branch-name>`
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

## Pre-Commit Verification
1. **Check Staged Files Context and Location**:
   - Run `git status` and `git diff --cached` to examine all staged changes
   - Verify each file is in the correct directory for its environment
   - For multi-environment changes, ensure:
     - Each environment has its own correctly-named file/directory
     - Environment-specific values match their respective environments
     - Configuration structure is consistent across environments
   - Check for common issues:
     - Wrong environment values in wrong files
     - Inconsistent naming conventions
     - Files in incorrect directory paths

2. **Report Verification Results**:
   - Summarize file locations and their contexts
   - Highlight any environment-specific configurations found
   - Note any potential issues or mismatches
   - Confirm if changes are appropriate for their locations

3. **Proceed with Commit**:
   - Only after verification, follow the standard commit workflow:
     - Review git status for untracked files
     - Review git diff for all changes
     - Draft appropriate commit message in Korean
     - Create commit with proper attribution

## Branch Strategy
- **Protected branches**: main, master, develop (and any branch marked as default)
- **If currently on a protected branch**: 
  1. Create a new branch with appropriate naming convention
  2. Switch to the new branch
  3. Then proceed with commit
- **Branch naming convention**:
  - `feature/description` - for new features
  - `fix/description` - for bug fixes
  - `docs/description` - for documentation
  - `refactor/description` - for code refactoring
  - `test/description` - for tests

## Context
- Current git status: `git status`
- Current git diff (staged and unstaged changes): `git diff HEAD`
- Current branch: `git branch --show-current`
- Recent commits: `git log --oneline -10`

## Your task
1. **Check current branch and create new branch if needed**
2. Based on the changes, create a single git commit
3. Please perform a git commit with the staged files using an appropriate commit message with conventional commit prefixes
