# WebRTCSampleApp Demo

This project is a simple iOS demo app that shows how to use the RTCPlayer class to play a live stream using WebRTC.

## Develop Environment Requirements
- Xcode 14.0+
- iOS 14+
- Swift 5.0+

## How to integrate the KKSPlayer iOS SDK

When you want to develop an own iOS application using the KKSPlayer iOS SDK read through the following steps.

### Adding the SDK Directly

When using Xcode, go to the General page or your app target and add the SDK bundle (KKSPlayer.xcframework) under Linked Frameworks and Libraries.

### Add BV Player Utility via Swift Package Manager (SPM).
Open the SA in Xcode as detailed in the earlier section (Opening the SA).
For adding the SDK via SPM, please follow the instructions [here](https://github.com/BlendVision/bvplayerutility.git).

## Usage

1. Clone this repository
2. Open the `WebRTCSampleApp.xcodeproj` file in Xcode
3. Build and run the app on a device or simulator
4. Tap the "Start Subscribe" button to start playing the stream
5. Tap the "Mute Audio" button to mute the audio track
6. Use the volume slider to adjust the volume level
7. Tap the "Stop Subscribe" button to stop playing the stream

## API Usage

To use the WebRTC API in your own project, you can use the `RTCPlayer` class.

### Initializing RTCPlayer

```swift
let rtcPlayer = RTCPlayer()
```

### Loading a stream

```swift
let sourceConfig = RTCSourceConfig(url: URL(string: "STREAM_URL")!,
                                   token: "STREAM_TOKEN")
rtcPlayer.load(sourceConfig: sourceConfig)
```

### Unloading a stream

```swift
rtcPlayer.unload()
```

### Muting the audio track

```swift
rtcPlayer.isMuted = true
```

### Adjusting the volume level

```swift
rtcPlayer.volume = 0.5
```

### Delegates
The purpose of this function is to handle the user tapping on the RTCRenderView instance. 
```swift
func rednerView(_ view: RTCRenderView, didTapAtPoint point: CGPoint) {}
```


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
