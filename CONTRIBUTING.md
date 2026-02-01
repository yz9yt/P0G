# Contributing to P0G

Thank you for your interest in contributing to **Project 0 Gravity**! This document provides guidelines for contributing to the P0G methodology and tooling.

---

## How to Contribute

### 🐛 Reporting Bugs

Found a bug? Please open an issue with:
- **Description**: Clear description of the bug
- **Steps to Reproduce**: Exact steps to trigger the issue
- **Expected Behavior**: What should happen
- **Actual Behavior**: What actually happens
- **Environment**: Antigravity version, OS, etc.

### 💡 Suggesting Features

Have an idea for enhancing P0G? Open an issue with:
- **Use Case**: What problem does it solve?
- **Proposed Solution**: How would it work?
- **Alternatives**: Other approaches considered
- **Impact**: Who benefits from this?

### 📖 Improving Documentation

Documentation improvements are always welcome:
- Fix typos or unclear explanations
- Add examples or use cases
- Translate to other languages
- Improve workflow clarity

### 🔧 Code Contributions

#### Areas for Contribution

1. **Workflow Enhancements**: Improve `/p0g-*` workflows
2. **Prompts**: Refine agent prompts for better guidance
3. **Skills**: Add new safety or automation skills
4. **Templates**: Create project templates for common stacks
5. **Verification Tools**: Better verification command generators

#### Process

1. **Fork** the repository
2. **Create a branch**: `git checkout -b feature/your-feature-name`
3. **Make changes** following the P0G methodology itself:
   - Create `prd.json` for your contribution
   - Break down into atomic tasks
   - Verify each change
4. **Test thoroughly**: Run through a complete P0G workflow
5. **Document**: Update README or add new docs
6. **Commit**: Use clear, descriptive commit messages
7. **Submit PR**: Describe changes, testing done, and impact

---

## Development Guidelines

### Code Style

- **Workflows**: Use markdown with clear sections
- **Prompts**: Clear, actionable instructions in English
- **Scripts**: POSIX-compliant bash when possible
- **JSON**: Follow existing `prd.json` schema

### Testing

Before submitting:
- [ ] Test the workflow with a real project
- [ ] Verify all verification commands work
- [ ] Check documentation is updated
- [ ] Ensure backwards compatibility

### Commit Messages

Format:
```
<type>: <short description>

<optional longer description>

<optional footer>
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code refactoring
- `test`: Test additions or changes
- `chore`: Maintenance tasks

Example:
```
feat: Add rollback verification to /p0g-loop

Adds automated backup verification before rollback operations
to prevent corrupted backup restoration.

Closes #42
```

---

## Pull Request Guidelines

### Before Submitting

- [ ] Code follows project style guidelines
- [ ] Documentation is updated
- [ ] All tests pass
- [ ] Commit messages are clear
- [ ] Branch is up to date with main

### PR Description Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Refactoring

## Testing
How was this tested?

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] Tests added/updated
- [ ] No breaking changes
```

---

## Community Guidelines

### Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what's best for the community
- Show empathy toward others

### Getting Help

- Check existing issues and documentation first
- Ask in GitHub Discussions for questions
- Tag maintainers only when necessary

---

## Recognition

Contributors will be:
- Listed in the README
- Credited in release notes
- Acknowledged in the community

---

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for making P0G better! 🚀**
