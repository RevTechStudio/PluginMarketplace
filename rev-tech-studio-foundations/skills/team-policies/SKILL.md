---
name: Team Policies
description: Development policies and interaction guidelines for team collaboration. Apply when making technical decisions, selecting technologies, implementing features, code reviews, or interacting with users. Ensures consistency in coding practices, architectural choices, and communication patterns across the project.
---

# Team Policies

## Basic Rules

### Emphasize Consistency

- **Follow coding standards**: All code must adhere to unified style and conventions
- **Unified naming conventions**: Use consistent naming patterns throughout the project
- **Unified architecture patterns**: Apply the same solution patterns to the same problems
- **Unified document formats**: All documents follow common formats and styles

### Technology Selection

- **Prioritize latest stable technologies**: Adopt latest stable versions including LTS (Long Term Support)
- **Avoid preview features**: Unless there are reasonable and limited justifications
- **Avoid legacy features**: Do not use deprecated APIs or outdated technologies
- **Minimize dependencies**: Introduce only the minimum necessary packages

### Project Conventions

- **Unified terminology**: Use "API" only for WEB APIs to avoid confusion
- **Japanese messages**: Write exception messages and log messages in Japanese
- **Version management**: Follow Semantic Versioning (SemVer)

### Development Practices

- **Testing**: Create unit tests for major features when instructed by users
- **Code review**: Conduct reviews for important changes
- **Continuous improvement**: Regularly review and improve technical debt
- **Avoid over-abstraction**: Avoid designs that excessively consider future extensibility

## Interaction Rules

### Language Usage

- **Think in English, communicate in Japanese**: Internal thinking and reasoning should be in English, but all communication with users should be in Japanese
- **Technical terms**: Use English technical terms when appropriate, with Japanese explanations when needed

### Distinguish Questions from Instructions

- **Don't treat questions as instructions**: When users ask questions, provide answers or suggestions first rather than immediately modifying code
- **Wait for explicit instructions**: Do not make code changes until users give clear instructions like "fix it" or "implement it"
- **Explain changes**: Before modifying code, explain what and how you will change

### Question Format

When asking users questions, use the following format:

```markdown
1. **[質問の背景・理由]**

A. **[Aの選択肢]**: [説明]
B. **[Bの選択肢]**: [説明]
C. **[Cの選択肢]**: [説明]
D. **その他**

**推奨**: **[推奨する選択肢]** - [なぜその選択肢を推奨するのかの具体的な理由]
```

### Decision-Making Process

- **Separate proposals from execution**: When multiple options exist, present proposals and seek user judgment
- **Proceed step by step**: Break large changes into smaller steps and obtain user approval at each step
- **Present alternatives**: When possible, present multiple approaches for users to choose from
- **No automatic execution without confirmation**: Always confirm when user intent is unclear
