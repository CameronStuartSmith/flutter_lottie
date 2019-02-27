# flutter_lottie

Use Lottie in Flutter.

Supports both iOS and Android using [lottie-ios](https://github.com/airbnb/lottie-ios) and [lottie-android](https://github.com/airbnb/lottie-android)

## Current Status

Supports most features that both iOS and Android support.
Only supports changing color and opacity through value delegates. More delegates will come later.
Example in the github repo includes a good intro into using the library.

## IMPORTANT NOTE

To use with iOS, you will need to add this key to your info.plist file located in:
project/ios/Runner/Info.plist

```
<key>io.flutter.embedded_views_preview</key>
<true />
```
