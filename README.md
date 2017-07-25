# jsonPerf

Performance comparison of `JSONDecoder` and `JSONSerializaton` decoding and returning a struct from a 7 MB JSON.
- [swift-evolution/0166](https://github.com/apple/swift-evolution/blob/master/proposals/0166-swift-archival-serialization.md)
- [swift-evolution/0167](https://github.com/apple/swift-evolution/blob/master/proposals/0167-swift-encoders.md)

![macOS](https://github.com/quanvo87/jsonPerf/blob/master/Assets/macOS.png)

macOS: `JSONEncoder` was 10.95% *slower* than `JSONSerialization` + object mapping.

![Linux](https://github.com/quanvo87/jsonPerf/blob/master/Assets/Linux.png)

Linux: `JSONEncoder` was 0.28% *faster* than `JSONSerialization` + object mapping.

### Notes
The `JSONEncoder` bars show performance of `decoder.decode()` where `decoder` is a previously instantiated `JSONDecoder`.

The `JSONSerialization` bars show the total performance of `JSONSerialization.jsonObject`, a cast of that return value to `[String: Any]`, and then instantiating a struct from that dictionary.

## Credits
Borrowed ideas from [JSONShootout](https://github.com/bwhiteley/JSONShootout). Also using their large JSON file.
