# LegacyVideoPlayer

A video player for swiftUI

## Installation

### For Swift Packages

Add a dependency in your your `Package.swift`

```swift
    .package(name: "LegacyVideoPlayer", url: "https://github.com/perimeter-inc/LegacyVideoPlayer", from: "1.0.0")
```


## Usage:

```swift
    LegacyVideoPlayer(url: url) { videoOverlay }
        .play(isLooping: true)
```


