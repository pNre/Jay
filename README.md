# Jay

Generic JSON Codable implementation inteded as an alternative to `JSONSerialization`

# How-to

## Installation

### Swift Package Manager
To install Jay using the Swift Package Manager add a dependency to your Package.swift. Please refer [to the documentation](https://github.com/apple/swift-package-manager/tree/master/Documentation) if you need help with the Package.swift syntax.

## Decoding

`JSON` allows decoding any JSON string/data:

```swift
import Jay

let data = "{\"hello\": [\"world\"]}".data(using: .utf8)!
let j = try! JSONDecoder().decode(JSON.self, from: data)
```

`print(j)` outputs:

```swift
▿ JSON
  ▿ dictionary : 1 element
    ▿ 0 : 2 elements
      - key : "hello"
      ▿ value : JSON
        ▿ array : 1 element
          ▿ 0 : JSON
            - string : "world"
```

### Accessing decoded data

`JSON` also supports dynamic member lookup and Int subscripting allowing easier access to the decoded data.

Continuing from the previous example:

```swift
// a = JSON.array([JSON.string("world")])
let a = json.hello!
// assign JSON.string("world") to s
let s = a[0]!
```

## Encoding

```swift
let object: JSON = .dictionary([
    "hello": .array([.string("world")])
])

let data = try! JSONEncoder().encode(object)
```
