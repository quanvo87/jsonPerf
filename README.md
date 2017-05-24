# jsonPerf

Performance comparison of `JSONDecoder`, `JSONSerializaton`, and `SwiftyJSON`.
- [swift-evolution/0166](https://github.com/apple/swift-evolution/blob/master/proposals/0166-swift-archival-serialization.md)
- [swift-evolution/0167](https://github.com/apple/swift-evolution/blob/master/proposals/0167-swift-encoders.md)
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

![perf graph](https://github.com/quanvo87/jsonPerf/blob/master/Assets/chart.png)

## Notes
* `JSONDecoder` decodes and returns a struct in one go, so you only see one bar for it.
* For `JSONSerialization` and `SwiftyJSON`, separate calls were made to decode the data, then create a struct from it.
* The object mapping for `SwiftyJSON` and `JSONSerialization` happens in initializers written by the user. View mine in `/Sources`.
* Under the covers, `SwiftyJSON` uses `JSONSerialization` to decode {citation needed}.
* There are additional tests for a `SimpleUser`, `MediumUser`, and `ComplexUser` in `/Tests`. Performance is noted in the test files, or clone and try them yourself.
* `JSONDecoder` has a few methods and configuration options. The only one used here is `decode()`.

## Takeaways
As the JSON grew in size, performance of the three converged somewhat. This means, according to [JSONShootout](https://github.com/bwhiteley/JSONShootout), `JSONDecoder` is not the most performant decoder out there. It still offers some advantages.

Advantages:
- Faster than SwiftyJSON in all the test cases in this project.
- In some cases, the compiler can generate the needed code to make your object conform to `Decodable` (a requirement to use `JSONDecoder`). In these cases, you do not have to implement a JSON initializer, which can be time consuming and error prone.

Disadvantages:
- The object you're decoding to must conform to `Decodable`.
- Not as fast as `JSONSerialization` or other decoders out there (though can be easier to use).

## Credits
Most borrowed ideas from [JSONShootout](https://github.com/bwhiteley/JSONShootout). Also using their large JSON file.
