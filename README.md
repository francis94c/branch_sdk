# branch_sdk

[![Build](https://github.com/francis94c/branch_sdk/actions/workflows/main.yml/badge.svg)](https://github.com/francis94c/branch_sdk/actions/workflows/main.yml) [![codecov](https://codecov.io/gh/francis94c/branch_sdk/branch/master/graph/badge.svg?token=KCPSZJHEO9)](https://codecov.io/gh/francis94c/branch_sdk) [![pub package](https://img.shields.io/pub/v/branch_sdk.svg)](https://pub.dev/packages/branch_sdk) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

[![Branch](https://github.com/francis94c/branch_sdk/blob/master/assets/images/branch.png?raw=true)](https://branch.io)

This plugin is a wrapper for the [Branch](https://branch.io) SDK.

## Features

- Basic Integration.
- Install Attribution.

Note: This plugin is still in alpha and provides little interfacing with the Branch SDK at the moment. Rest assured, the plugin is still being actively developed. Provided interfaces/features are production ready.

## Getting started

Add the below to your `pubspec.yaml` file.

```yaml
dependencies:
  branch_sdk: ^1.0.0-alpha.3
```

and run `flutter pub get`

For iOS you need to go further in to your `ios` folder and run `pod install`. You need to install `cocoapods` for that.

and import with

```dart
import 'package:branch_sdk/branch_sdk.dart';
```

## Usage

### Basic Integration

To basically setup the Branch SDK you need to follow the below instructions based on platform of choice.

### iOS Setup

As described in the official docs [here](https://help.branch.io/developers-hub/docs/ios-full-reference#register-your-app), Add the below to your `Info.plist` file

```xml
<!-- App Key -->
<key>branch_key</key>
<string>key_live_or_test</string>
```

```xml
<!-- Register a URI Scheme -->
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
	<array>
	  <string>your_app_scheme</string>
	</array>
  </dict>
</array
```

You can obtain the live or test keys from your DashBoard. If you want to set the test and prod keys at the same time, you can add this instead in your `Info.plist` file for the `branch_key` value.

```xml
<key>branch_key</key>
<dict>
  <key>live</key>
  <string>live_key</string>
  <key>test</key>
  <string>test_key</string>
</dict>
```

To support Universal Links, follow the instructions [here](https://help.branch.io/developers-hub/docs/ios-full-reference#support-universal-linking-ios-9-and-above)

### Android Setup

Add the below to your `AndroidManifest.xml` file just within the `<application>` tag.

```xml
<meta-data android:name="io.branch.sdk.BranchKey" android:value="key_live_abc" />
<meta-data android:name="io.branch.sdk.BranchKey.test" android:value="key_test_abc" />
<!-- Set to use Live or Test Key -->
<meta-data android:name="io.branch.sdk.TestMode" android:value="true" />
```

## Initializing

To initialize Branch do the following:

```dart
import 'package:branch_sdk/branch_sdk.dart';

BranchSdk.init(debug: true); // Set debug to true to use test key and enable logging. Note io.branch.sdk.TestMode in AndroidManifest.xml must be set to true for debug:true to work.
```

To guarantee the success of this function, ensure you've called the below in the app's main function

```dart
WidgetsFlutterBinding.ensureInitialized();
```

To verify your integration, do the following:

```dart
import 'package:branch_sdk/branch_sdk.dart';

BranchSdk.init(debug: true);

BranchSdk.validateSDKIntegration(); // Remember to remove this in production.
```

## Additional information

For a practical example, see the package example section.

## Contributing

Pull requests are welcome.