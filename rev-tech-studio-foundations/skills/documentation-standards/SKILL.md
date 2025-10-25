---
name: Documentation Standards
description: Common documentation standards for all project documents. Apply when creating or reviewing any documentation including README, design docs, and specifications.
---

# Documentation Standards

Common rules to apply when creating all documentation.

## Basic Rules

### Language

**Documents should be written in Japanese unless the user explicitly specifies otherwise.**

- Default language: Japanese
- Use English only when explicitly requested
- Technical terms may use English as needed

### Write Concisely

- Avoid verbose expressions
- Make key points clear
- Use bullet points effectively
- Keep sentences short

### Code Prohibition in Development Documents

**Do not include code or pseudocode in development documents such as requirements and design specifications**:

- Requirements documents: Describe only business and functional requirements
- Design documents: Describe architecture, class structure, data flow, etc.
- If code examples are needed, provide separate sample code files

### Diagram Guidelines

**Use Mermaid syntax for diagrams**:

- Architecture diagrams: Flowcharts, sequence diagrams
- Data models: ER diagrams, class diagrams
- Manage as text-based rather than image files
- Easier version control
- Use concrete names for node IDs instead of abstract symbols like A, B, C
- Use terminator symbols for start and end nodes (e.g., `([Start])`, `([End])`)

## Linting Rules

### markdownlint-cli2

**When available, use markdownlint-cli2 for validation**:

```bash
# Run check
markdownlint-cli2 "**/*.md"
```

**Do not use auto-fix (--fix)**:

- Prevents unintended changes
- Review and apply corrections manually

## Checklist

After creating documentation, verify the following:

- [ ] Written in Japanese (unless user specified otherwise)
- [ ] Writing is concise and clear
- [ ] Development documents contain no code or pseudocode
- [ ] Diagrams are written in Mermaid syntax
- [ ] Checked with markdownlint-cli2 (if available)
