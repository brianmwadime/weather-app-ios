# Naming Conventions

## Protocols

When naming protocols, we generally follow the [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/#strive-for-fluent-usage):

- Protocols that describe a _capability_ should be named using the suffixes `able`, `ible`, or `ing` (e.g. `ModelConvertible`).


For protocols that are specifically for one type only, it is acceptable to append `Protocol` to the name.

```swift
public protocol WeatherServiceProtocol { }

final class WeatherService: WeatherServiceProtocol { }
```

We usually end up with cases like this when we _have_ to create a protocol to support mocking unit tests.

## Test Methods

Contrary to the standard [Camel case](https://en.wikipedia.org/wiki/Camel_case) style in Swift functions, test methods should use [Snake case](https://en.wikipedia.org/wiki/Snake_case). We concluded that this helps with readability especially since test methods can be quite long.


