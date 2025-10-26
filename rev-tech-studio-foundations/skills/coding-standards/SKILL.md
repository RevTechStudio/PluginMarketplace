---
name: Coding Standards
description: C# coding standards and best practices. Apply when writing C# code, reviewing code, or discussing code quality and conventions.
---

# Coding Standards

## Naming Conventions

### **CRITICAL: Underscore Prefix Prohibition**

**Underscore prefixes (`_`) are strictly prohibited in all naming contexts.** This is the most important naming rule and must be enforced without exception.

### General Naming Rules

- Names should clearly indicate purpose and role
- Avoid uncommon abbreviations
- Boolean values should be prefixed with `is`, `has`, `can`, `should`
- Constants use UPPER_SNAKE_CASE
- Classes, methods, properties, and constants use PascalCase
- Local variables, parameters, and private fields use camelCase
- Interfaces use `I` + PascalCase

## Code Design

- Functions should have single responsibility
- Aim for under 100 lines
- Maximum 3 levels of nesting
- Use guard clauses for early returns
- Avoid magic numbers, use constants
- **Never omit braces** (always use braces even for single-line statements)
- **Keep short operations on one line** (when conditions and operations are short and fit on one line, write them on one line with braces)

## Comments and Documentation

- Write about "why" you're doing something
- **TODO/FIXME comments are prohibited** - create issues instead
- Delete commented-out code
- Add documentation comments to all classes and methods (including non-public)

## Exception Handling and Logging

- Use exceptions only for exceptional situations
- Don't swallow exceptions
- Create custom exceptions when standard exceptions are insufficient
- Exception class names should end with `Exception`
- Log sufficient information on errors

### Log Levels

- **Debug**: Detailed information for development
- **Info**: Startup, shutdown, major operations
- **Warning**: Needs attention but processing can continue
- **Error**: Recoverable errors
- **Critical**: Severe errors requiring system shutdown

## Performance

- Avoid premature optimization
- Use `using` to ensure resource disposal
- Implement I/O operations asynchronously

## Security

- Never hardcode passwords or API keys
- Always validate and sanitize external input
- Regularly update dependencies and check for vulnerabilities

## C# Style

- Enable nullable reference types
- Use `var` when type is obvious
- Use expression-bodied members (`=>`) for simple operations
- Use string interpolation `$"..."`
- Leverage LINQ for collection operations
- Use `using` statements or declarations for resource management
- Use record types for immutable data
- Avoid `async void` except for event handlers
- Async return values should be `Task` or `ValueTask`

## Performance Optimization

- Consider `Span<T>`, `Memory<T>` for frequent memory operations
- Consider `ValueTask` for async operations that complete synchronously often
- Use `StringBuilder` for string concatenation in loops

## Attributes and Annotations

- Mark deprecated code with `[Obsolete]` and suggest alternatives
- Use appropriate attributes as needed

## Modern Features

Modern C# features to actively use:

- Record types
- init accessors
- Top-level statements
- Enhanced pattern matching
- file-scoped types
- Raw string literals
- required modifier
- Primary constructors
- Collection expressions
- Type aliases
- params collections
- Global usings (with project agreement)
- File-scoped namespaces (with project agreement)

<!-- AI Ignore Start -->
[SKILL-Japanese.md](SKILL-Japanese.md)
<!-- AI Ignore End -->
