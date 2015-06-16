tryq
=======================

_swift 2.0_ lacks the `try?` operator while the `try` and `try!` operators are provided. The `tryq` function works like `try?`.

```swift
// let result: Int? = try? foo(42)
let result: Int? = tryq(try foo(42))
```

It is identical to the following.

```swift
// too complicated
let result: Int?
do {
    result = try foo(42)
} catch {
    result = nil
}
```

`try?` is desired also because it can be used in expressions.

```swift
// let result = (try? foo(42)).map { $0 * $0 }
let result = tryq(try foo(42)).map { $0 * $0 }
```

I expect that `try?` will be provided in the future. Use `tryq` as the temporary alternative of `try?`.

Implementation
-----------------------

`tryq` is a very simple function implemented in [tryq.swift](tryq/tryq.swift).

```swift
public func tryq<T>(@autoclosure f: () throws -> T) -> T? {
    do {
        return try f()
    } catch {
        return nil
    }
}
```

License
-----------------------

[The MIT License](LICENSE)
