# jsonPerf

![perf graph](https://github.com/quanvo87/jsonPerf/blob/master/jsonPerf.png)

#### Notes:
* `JSONDecoder` decodes and returns a struct in one go.
* For `JSONSerialization` and `SwiftyJSON`, separate calls were made to decode the data, then create a struct from it.
* The `Both` columns include a check to make sure the returned struct is correct.
* Under the covers, `SwiftyJSON` uses `JSONSerialization` to decode.
* The object mapping for `SwiftyJSON` and `JSONSerialization` must happen in initializers written by the user. View mine in `/Sources`.

## Summary
* For simple JSON files, the three have similar performance.
* For "medium" JSON files, `SwiftyJSON` is more than twice as slow than the others, with `JSONSerialization` being the fastest.
* For "complex" JSON files, `JSONDecoder` is not quite twice as fast as `SwiftyJSON` anymore, and also begins to lag behind `JSONSerialization` much more.
* A large advantage of using `JSONDecoder` is not having to write JSON initializers for your objects. These initializers grow in complexity with your object and can be time consuming and error prone to write.

## The JSON Files

#### Simple
```json
{
  "id": "87B65886-CCE5-498E-8110-9ED8018621CE"
}
```

#### Medium
```json
{
  "id": "87B65886-CCE5-498E-8110-9ED8018621CE",
  "registered": true,
  "name": "Mario",
  "address": {
    "number": 123,
    "street": "Mushroom St",
    "type": "apartment"
  }
}
```

#### Complex
```json
{
  "id": "87B65886-CCE5-498E-8110-9ED8018621CE",
  "registered": true,
  "addresses": [
    {
      "number": 123,
      "street": "Mushroom St",
      "type": "apartment"
    },
    {
      "number": 999,
      "street": "Pipe Way",
      "type": "business"
    },
    {
      "number": 123,
      "street": "6th St",
      "type": "home"
    },
    {
      "number": 4,
      "street": "Goldfield Rd",
      "type": "apartment"
    },
    {
      "number": 71,
      "street": "Pilgrim Avenue",
      "type": "business"
    }
  ],
  "name": "Mario",
  "pets": [
    {
      "name": "Toad",
      "species": "dog",
      "diet": [
        "steak"
      ]
    },
    {
      "name": "Bowser",
      "species": "cat",
      "diet": [
        "fish"
      ]
    },
    {
      "name": "Yoshi",
      "species": "dragon",
      "diet": [
        "steak",
        "fish",
        "people"
      ]
    },
    {
      "name": "Patty",
      "species": "cat",
      "diet": [
        "steak"
      ]
    },
    {
      "name": "Teresa",
      "species": "dragon",
      "diet": [
        "steak",
        "fish",
        "people"
      ]
    },
    {
      "name": "Genevieve",
      "species": "cat",
      "diet": [
        "steak"
      ]
    },
    {
      "name": "Harriet",
      "species": "dragon",
      "diet": [
        "steak",
        "fish"
      ]
    },
    {
      "name": "Anthony",
      "species": "dog",
      "diet": [
        "steak"
      ]
    },
    {
      "name": "Victoria",
      "species": "dragon",
      "diet": [
        "steak"
      ]
    },
    {
      "name": "Jessica",
      "species": "dog",
      "diet": [
        "steak",
        "fish"
      ]
    }
  ]
}
```
