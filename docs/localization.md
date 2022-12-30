# Localization

During development, using [`NSLocalizedString()`](https://developer.apple.com/documentation/foundation/nslocalizedstring) to reference strings in `Localizable.strings`.

## Always Add Comments

Always add a meaningful comment. If possible, describe where and how the string will be used. If there are placeholders, describe what each placeholder is.

```swift
// Do
let title = NSLocalizedString("Hello world %1$@",
                              comment: "Welcome text. %1$@ is a placeholder for the count.")
```

```swift
// Avoid
let title = NSLocalizedString("Hello world %1$@", comment: "")
```

Comments help give more context to translators.

## Always Use Positional Placeholders

Always include the positional index of parameters, even if you only have one placeholder in your string. For example, instead of using `%@` as the placeholder, use `%1$@` instead. Positional placeholders allow translators to change the order of placeholders or repeat them if necessary.

## Do Not Use Variables

Do not use variables as the argument of `NSLocalizedString()`. The string value will not be automatically picked up.

```swift
// Do
let myText = NSLocalizedString("This is the text I want to translate.", comment: "Put a meaningful comment here.")
myTextLabel?.text = myText
```

```swift
// Don't
let myText = "This is the text I want to translate."
myTextLabel?.text = NSLocalizedString(myText, comment: "Put a meaningful comment here.")
```

## Do Not Use Interpolated Strings

Interpolated strings are harder to understand by translators and they may end up translating/changing the variable name, causing a crash.

Use [`String.localizedStringWithFormat`](https://developer.apple.com/documentation/swift/string/1414192-localizedstringwithformat) instead.

```swift
// Do
let year = 2019
let template = NSLocalizedString("© %1$d Acme, Inc.", comment: "Copyright Notice")
let str = String.localizeStringWithFormat(template, year)
```

```swift
// Don't
let year = 2019
let str = NSLocalizedString("© \(year) Acme, Inc.", comment: "Copyright Notice")
```

## Multiline Strings

For readability, you can split the string and concatenate the parts using the plus (`+`) symbol.

```swift
// Okay
NSLocalizedString(
    "Take some long text here " +
    "and then concatenate it using the '+' symbol."
    comment: "You can even use this form of concatenation " +
        "for extra-long comments that take the time to explain " +
        "lots of details to help our translators make accurate translations."
)
```
