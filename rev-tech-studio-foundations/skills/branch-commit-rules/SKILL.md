---
name: Branch and Commit Rules
description: Naming conventions and formatting standards for branches, commits, and pull requests. Apply when creating branches, writing commit messages, or preparing pull requests.
---

# Branch and Commit Rules

## Branch Naming Convention

This repository follows these branch naming conventions:

- **`main`**: Main branch (production equivalent)
- **`feat/*`**: Feature branches
- **`fix/*`**: Bug fix branches
- **`refactor/*`**: Refactoring branches
- **`env/*`**: Environment setup branches
- **`claude/*`**: Branches automatically managed by Claude Code

## Commit Message Rules

Use commit messages that conform to **Conventional Commits**:
<https://www.conventionalcommits.org/en/v1.0.0/>

### Basic Format

```markdown
<type>: <description>

[optional body]

[optional footer(s)]
```

### Rules

- **Do not use scope**
- **description**: Written in English or Japanese
- **body**: Written in English or Japanese (optional, preferably in bullet points)
- **type**: Use one of the following:
  - `feat`: New feature
  - `fix`: Bug fix
  - `refactor`: Refactoring (no functional changes)
  - `docs`: Documentation only changes
  - `style`: Changes that do not affect the meaning of the code (formatting, semicolons, etc.)
  - `test`: Adding or modifying tests
  - `chore`: Changes to build process or tools
- **Related issue references**: If there is a related issue, it is recommended to add `Refs: #issue_number` in the footer section. This clearly links commits to issues.

### Commit Message Examples

```text
feat: add user authentication

- Implement user authentication using OAuth 2.0
- Support Google, GitHub, and GitLab providers

Refs: #123
```

## Pull Request (PR) Rules

### PR Title

Use the same format as commit messages:

- Format: `<type>: <description>`
- description is written in English or Japanese
- Related issue references: If there is a related issue, it is recommended to add `( #issue_number )` at the end of the title. This clearly links PRs to issues.

### PR Title Examples

```markdown
feat: add dark mode toggle
fix: fix layout issue on login screen
refactor: reorganize API call logic ( #321 )
docs: add environment setup instructions to README ( #234 )
```

### PR Body

Provide a detailed description of the changes:

- **What was changed**: Features implemented or fixes made
- **Why it was changed**: Background and reasons for the change

### PR Body Example

```markdown
## Changes

Added functionality for users to switch between dark mode and light mode.

## Reason

Many users have requested dark mode support.
The goal is to improve visibility and enhance user experience.

## Implementation Details

- Added toggle switch component
- Persist theme state in localStorage
- Manage themes with CSS custom properties
```

<!-- AI Ignore Start -->
[SKILL-Japanese.md](SKILL-Japanese.md)
<!-- AI Ignore End -->
