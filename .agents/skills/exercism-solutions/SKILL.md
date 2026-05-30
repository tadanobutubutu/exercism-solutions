```markdown
# exercism-solutions Development Patterns

> Auto-generated skill from repository analysis

## Overview
This skill documents the development patterns and conventions used in the `exercism-solutions` repository, which contains TypeScript solutions to Exercism exercises. It covers file organization, code style, testing approaches, and provides guidance for contributing consistent code.

## Coding Conventions

### File Naming
- **PascalCase** is used for filenames.
  - Example: `HelloWorld.ts`, `LeapYear.ts`

### Import Style
- **Relative imports** are used to reference other files.
  - Example:
    ```typescript
    import { isLeapYear } from './LeapYear';
    ```

### Export Style
- **Named exports** are preferred.
  - Example:
    ```typescript
    export function hello(): string {
      return 'Hello, World!';
    }
    ```

### Commit Patterns
- Commit messages are **freeform** and do not follow a strict prefix or type.
- Average commit message length: ~36 characters.

## Workflows

### Adding a New Solution
**Trigger:** When adding a new solution to an Exercism exercise  
**Command:** `/add-solution`

1. Create a new TypeScript file using PascalCase (e.g., `TwoFer.ts`).
2. Implement the solution using named exports.
3. Create a corresponding test file (e.g., `TwoFer.test.ts`).
4. Use relative imports in your test file to import the solution.
5. Run tests to verify correctness.
6. Commit your changes with a descriptive message.

### Updating an Existing Solution
**Trigger:** When improving or fixing an existing solution  
**Command:** `/update-solution`

1. Open the relevant solution file.
2. Make the necessary changes, following coding conventions.
3. Update or add tests as needed.
4. Run tests to ensure all pass.
5. Commit with a clear message describing the update.

### Running Tests
**Trigger:** When verifying your solution  
**Command:** `/run-tests`

1. Identify the test file(s) matching `*.test.*`.
2. Use the project's preferred test runner (framework not specified; consult project documentation or use a standard TypeScript test runner).
3. Run the tests and review the results.

## Testing Patterns

- Test files follow the pattern: `*.test.*` (e.g., `LeapYear.test.ts`).
- The testing framework is not specified; use a standard TypeScript-compatible test runner (e.g., Jest, Mocha, or similar).
- Tests import solution files using relative imports.
  - Example:
    ```typescript
    import { isLeapYear } from './LeapYear';

    describe('LeapYear', () => {
      it('should identify leap years', () => {
        expect(isLeapYear(2020)).toBe(true);
      });
    });
    ```

## Commands

| Command           | Purpose                                      |
|-------------------|----------------------------------------------|
| /add-solution     | Add a new solution for an Exercism exercise  |
| /update-solution  | Update or improve an existing solution       |
| /run-tests        | Run all test files to verify correctness     |
```