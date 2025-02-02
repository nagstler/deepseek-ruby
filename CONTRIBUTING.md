# Contributing to Deepseek Ruby SDK

First off, thanks for taking the time to contribute! 🎉 👍

The following is a set of guidelines for contributing to the Deepseek Ruby SDK. These are mostly guidelines, not rules. Use your best judgment, and feel free to propose changes to this document in a pull request.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Enhancements](#suggesting-enhancements)
  - [Your First Code Contribution](#your-first-code-contribution)
  - [Pull Requests](#pull-requests)
- [Development Process](#development-process)
  - [Set Up Your Environment](#set-up-your-environment)
  - [Running Tests](#running-tests)
  - [Coding Standards](#coding-standards)
- [Commit Messages](#commit-messages)

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the issue list as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* Use a clear and descriptive title
* Describe the exact steps which reproduce the problem
* Provide specific examples to demonstrate the steps
* Describe the behavior you observed after following the steps
* Explain which behavior you expected to see instead and why
* Include details about your configuration and environment

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

* Use a clear and descriptive title
* Provide a step-by-step description of the suggested enhancement
* Provide specific examples to demonstrate the steps
* Describe the current behavior and explain which behavior you expected to see instead
* Explain why this enhancement would be useful

### Your First Code Contribution

Unsure where to begin contributing? You can start by looking through these issues:

* `beginner` - issues which should only require a few lines of code
* `help-wanted` - issues which should be a bit more involved than `beginner` issues
* `documentation` - issues related to improving documentation

### Pull Requests

* Fill in the required template
* Do not include issue numbers in the PR title
* Follow the Ruby styleguides
* Include thoughtfully-worded, well-structured tests
* Update documentation for any changed functionality
* End all files with a newline

## Development Process

### Set Up Your Environment

1. Fork the repo
2. Clone your fork
3. Set up development environment:

```bash
bin/setup
```

### Running Tests

```bash
# Run all tests
bundle exec rake spec

# Run specific test file
bundle exec rspec spec/path/to/test_file.rb

# Run with specific line number
bundle exec rspec spec/path/to/test_file.rb:123
```

### Coding Standards

* Use 2 spaces for indentation
* Use snake_case for methods and variables
* Use CamelCase for classes and modules
* Keep lines under 100 characters
* Write descriptive commit messages
* Add tests for new code
* Update documentation

## Commit Messages

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```
type(scope): description

[optional body]

[optional footer]
```

Types:
* feat: A new feature
* fix: A bug fix
* docs: Documentation only changes
* style: Changes that do not affect the meaning of the code
* refactor: A code change that neither fixes a bug nor adds a feature
* perf: A code change that improves performance
* test: Adding missing tests or correcting existing tests
* chore: Changes to the build process or auxiliary tools

Example:
```
feat(client): add retry mechanism for failed requests

Added exponential backoff retry mechanism for failed API requests.
This helps handle temporary network issues and rate limits.

Closes #123
```