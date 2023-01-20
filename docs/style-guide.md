
# Coding Style Guide

We use the [Swit.org API Design Guidelines](https://swift.org/documentation/api-design-guidelines/) as a base.

## SwiftLint

We use [SwiftLint](https://github.com/realm/SwiftLint) to enforce our rules. It's integrated in the build process so you should see any violations in Xcode.

You can the lint check manually by executing `bundle exec rake lint` in the command line.

The SwiftLint rules are automatically enforced by [Hound](https://houndci.com) when pull requests are submitted.

## Braces

Prefer closing braces to be placed on a new line regardless of the number of enclosed statements.

## Parentheses

Parentheses around conditionals are not required.

## Forced Downcasts and Unwrapping

Avoid using `as!` to force a downcast, or `!` to force unwrap. Prefer using `as?` to attempt the cast, then deal with the failure case explicitly.

## Error Handling

Avoid using `try?` when a function may throw an error, as it would fail silently. We can use a `do-catch` block instead to handle and log the error as needed. 
