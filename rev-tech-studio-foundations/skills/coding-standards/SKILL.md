---
name: Coding Standards
description: C# coding standards and best practices. Apply when writing C# code, reviewing code, or discussing code quality and conventions.
---

# Coding Standards

## Naming Conventions

### **CRITICAL: Underscore Prefix Prohibition**

**Underscore prefixes (`_`) are strictly prohibited in all naming contexts.** This is the most important naming rule and must be enforced without exception.

```csharp
// ❌ BAD - Never use underscore prefixes
public class UserService
{
    private readonly IUserRepository _repository;  // WRONG
    private int _count;                             // WRONG
    private const int _MAX_SIZE = 100;             // WRONG
}

// ✅ GOOD - Use camelCase for private fields
public class UserService
{
    private readonly IUserRepository repository;  // CORRECT
    private int count;                             // CORRECT
    private const int MAX_SIZE = 100;             // CORRECT (constants use UPPER_SNAKE_CASE)
}
```

### General Naming Rules

- Names should clearly indicate purpose and role
- Avoid uncommon abbreviations
- Boolean values should be prefixed with `is`, `has`, `can`, `should`
- Constants use UPPER_SNAKE_CASE
- Classes, methods, properties, and constants use PascalCase
- Local variables, parameters, and private fields use camelCase
- Interfaces use `I` + PascalCase

```csharp
// Good
public class UserManager
{
    private readonly IUserRepository userRepository;
    public const int MAX_RETRY_COUNT = 3;

    public bool IsActive { get; set; }
    public bool HasPermission(string permission) { ... }
}

// Bad
public class user_manager
{
    private IUserRepository _repo;  // Wrong: underscore prefix
    public const int maxRetry = 3;

    public bool Active { get; set; }
}
```

## Code Design

- Functions should have single responsibility
- Aim for under 100 lines
- Maximum 3 levels of nesting
- Use guard clauses for early returns
- Avoid magic numbers, use constants
- **Never omit braces** (always use braces even for single-line statements)
- **Keep short operations on one line** (when conditions and operations are short and fit on one line, write them on one line with braces)

```csharp
// Good - guard clauses, braces present, short operations on one line
public User GetUser(int id)
{
    if (id <= 0) { return null; }

    if (!users.ContainsKey(id)) { return null; }

    return users[id];
}

// Bad - omitted braces
public User GetUser(int id)
{
    if (id <= 0)
        return null;  // NG: no braces

    return users[id];
}

// Bad - deep nesting
public User GetUser(int id)
{
    if (id > 0)
    {
        if (users.ContainsKey(id))
        {
            return users[id];
        }
    }
    return null;
}
```

## Comments and Documentation

- Write about "why" you're doing something
- **TODO/FIXME comments are prohibited** - create issues instead
- Delete commented-out code
- Add documentation comments to all classes and methods (including non-public)

```csharp
/// <summary>
/// Retrieves user information
/// </summary>
/// <param name="userId">User ID</param>
/// <returns>User information, or null if not found</returns>
public async Task<User?> GetUserByIdAsync(int userId)
{
    // Implement retry logic to avoid timeouts
    return await repository.FindAsync(userId);
}
```

## Exception Handling and Logging

- Use exceptions only for exceptional situations
- Don't swallow exceptions
- Create custom exceptions when standard exceptions are insufficient
- Exception class names should end with `Exception`
- Log sufficient information on errors

```csharp
// Good
public class UserNotFoundException : Exception
{
    public int UserId { get; }

    public UserNotFoundException(int userId)
        : base($"User with ID {userId} not found")
    {
        UserId = userId;
    }
}

try
{
    await ProcessDataAsync(data);
}
catch (Exception ex)
{
    logger.LogError(ex, "Failed to process data: {Data}", data);
    throw;
}
```

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

```csharp
// Good
await using var stream = File.OpenRead(path);
await using var connection = await connectionFactory.CreateAsync();

// Good - async I/O
public async Task<string> ReadFileAsync(string path)
{
    return await File.ReadAllTextAsync(path);
}
```

## Security

- Never hardcode passwords or API keys
- Always validate and sanitize external input
- Regularly update dependencies and check for vulnerabilities

```csharp
// Good
var apiKey = configuration["ApiKey"];

public User CreateUser(CreateUserRequest request)
{
    // Input validation
    if (string.IsNullOrWhiteSpace(request.Email)) { throw new ArgumentException("Email is required"); }

    // Sanitization
    var sanitizedName = HtmlEncoder.Default.Encode(request.Name);

    return new User { Name = sanitizedName, Email = request.Email };
}
```

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

```csharp
// Good - modern C# style
public record UserDto(int Id, string Name, string Email);

public class UserService
{
    private readonly IUserRepository repository;

    public UserService(IUserRepository repository) =>
        this.repository = repository;

    public async Task<UserDto?> GetUserAsync(int id)
    {
        var user = await repository.FindAsync(id);
        return user is not null
            ? new UserDto(user.Id, user.Name, user.Email)
            : null;
    }

    public async Task<List<UserDto>> GetActiveUsersAsync()
    {
        var users = await repository.GetAllAsync();
        return users
            .Where(u => u.IsActive)
            .Select(u => new UserDto(u.Id, u.Name, u.Email))
            .ToList();
    }
}
```

## Performance Optimization

- Consider `Span<T>`, `Memory<T>` for frequent memory operations
- Consider `ValueTask` for async operations that complete synchronously often
- Use `StringBuilder` for string concatenation in loops

```csharp
// Good - using StringBuilder
var builder = new StringBuilder();
foreach (var item in items)
{
    builder.AppendLine($"Item: {item}");
}
return builder.ToString();

// Good - using Span<T>
public int Sum(ReadOnlySpan<int> numbers)
{
    int sum = 0;
    foreach (var num in numbers)
    {
        sum += num;
    }
    return sum;
}
```

## Attributes and Annotations

- Mark deprecated code with `[Obsolete]` and suggest alternatives
- Use appropriate attributes as needed

```csharp
[Obsolete("Use GetUserByIdAsync instead")]
public User GetUser(int id) { ... }

[Required]
[StringLength(100)]
public string Name { get; set; }
```

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

```csharp
// Record types and primary constructors
public record User(int Id, string Name, string Email);

// required modifier
public class CreateUserRequest
{
    public required string Name { get; init; }
    public required string Email { get; init; }
}

// Pattern matching
public string GetUserStatus(User user) => user switch
{
    { IsActive: true, LastLoginDate: var date } when date > DateTime.Now.AddDays(-7)
        => "Active",
    { IsActive: true } => "Inactive",
    _ => "Disabled"
};

// Collection expressions
List<int> numbers = [1, 2, 3, 4, 5];
```
