---
name: Team Policy
description: Development policies and interaction guidelines for team collaboration. Use this skill at the beginning of a session or after executing the Clear command.
---

# Team Policy

## Most Important Rule

### No Development Under Ambiguous Conditions

- **Do not proceed with development when requirements are unclear**: Proceeding with ambiguity can lead to major issues.
- **Always confirm and clarify**: If specifications or expected behavior are unclear, always check with the user.
- **Explicitly state assumptions and obtain approval**: Do not act based on assumptions alone; always verify.
- **Align understanding before starting implementation**: If inconsistencies are found in documents, requirements, or specifications, report and resolve immediately.

### Do Not Ignore Contradictions

- **Immediate reporting**: When inconsistencies are discovered in documents or code, report them to the user immediately.
- **Request a resolution**: Ask the user how the identified contradiction should be resolved.
- **Follow the question format**: Use the standard question format when asking about contradiction resolution.

## Basic Rules

### Maintain Consistency

- **Follow coding standards**: All code must adhere to unified style and conventions.
- **Unified naming conventions**: Use consistent naming patterns throughout the project.
- **Unified architectural patterns**: Apply the same solution patterns to the same types of problems.
- **Unified documentation format**: All documents must follow a common format and style.

### Technology Selection

- **Prefer the latest stable versions**: Use the latest stable versions including LTS releases.
- **Avoid preview features**: Unless there is a well-founded and limited justification, do not use preview features.
- **Avoid legacy functions**: Do not use deprecated APIs or outdated technologies.
- **Minimize dependencies**: Introduce only the minimum required packages.

### Project Conventions

- **Unified terminology**: Use “API” exclusively for Web APIs to avoid confusion.
- **Messages in Japanese**: Exception and log messages must be written in Japanese.
- **Versioning**: Follow Semantic Versioning (SemVer).

### Development Practices

- **Testing**: Create unit tests for major features only when instructed by the user.
- **Code review**: Conduct reviews for important changes.
- **Continuous improvement**: Regularly review and reduce technical debt.
- **Avoid over-abstraction**: Do not over-engineer based on hypothetical future needs.

## Interaction Rules

### Language Usage

- **Think in English, communicate in Japanese**: Internal reasoning is done in English, but communication with the user is done entirely in Japanese.
- **Technical terms**: Use English terms when appropriate, adding Japanese explanations if needed.

### Requirement Clarification

- **No ambiguity allowed**: Do not proceed with implementation or documentation if requirements are unclear.
- **Always ask questions**: When encountering unclear specs, requirements, or expected behavior, always request clarification.
- **Clarify before taking action**: Get clear confirmation before beginning implementation or documentation work.
- **Confirm assumptions**: If assumptions must be made, state them explicitly and request user confirmation.

### Decision-Making Process

- **Separate proposal and execution**: If multiple choices exist, propose options and let the user decide.
- **Proceed step by step**: Break large changes into smaller steps and obtain approval at each stage.
- **Offer alternatives**: Provide multiple approaches when possible and let the user choose.
- **No automatic execution without confirmation**: Always confirm intent when unclear.

### Distinguishing Questions From Commands

- **Do not treat questions as commands**: Provide answers or suggestions first rather than immediately modifying code.
- **Wait for explicit instructions**: Do not modify code until the user explicitly states commands such as “please fix” or “please implement.”
- **Explain changes**: Before modifying code, explain what and how changes will be made.

### Question Format

When asking the user questions, use the following format:

```markdown
1. **[質問の背景・理由]**

A. **[Aの選択肢]**: [説明]
B. **[Bの選択肢]**: [説明]
C. **[Cの選択肢]**: [説明]
D. **その他**

**推奨**: **[推奨する選択肢]** - [なぜその選択肢を推奨するのかの具体的な理由]
```

<!-- AI Ignore Start -->
[SKILL-Japanese.md](SKILL-Japanese.md)
<!-- AI Ignore End -->