# LastfmClient
A Swifty last.fm api client using Codable.

Lastfm's API is not very good. Nested Dictionary, Nonexistent key, etc.  
If you use LastfmClient, you can handle last.fm api type-safely and Swifty.

# TODO

* [ ] User
  * [x] user.getTopTracks
  * [x] user.getRecentTracks
  * [x] user.getInfo
  * [ ] ...
* [ ] Track
* [ ] Tag
* [ ] Library
* [ ] Geo
* [ ] Chart
* [ ] Auth
* [ ] Artist
* [ ] Album

# Installation

```
pod install LastfmClient
```

# Usage

```swift
import LastfmClient

Configuration.shared.configure(apiKey: "YOUR_LASTFM_API_KEY")
let user = UserAPI(user: "star__hoshi")
user.getInfo { result in
    switch result {
    case .success(let user):
        XCTAssertEqual(user.name, "star__hoshi")
    case .failure(let error):
        XCTFail("\(error)")
    }
}
```

# Test

1. Get your lastfm api key from [here](https://www.last.fm/api/account/create).
2. Add `TestConfiguration.swift` to LastfmClientTests.
    * Please copy `TestConfiguration.sample.swift` and use it.
    * Set lastfm api key.
3. Run tests!
  
