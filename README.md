# branch_sdk

[![Build](https://github.com/francis94c/branch_sdk/actions/workflows/main.yml/badge.svg)](https://github.com/francis94c/branch_sdk/actions/workflows/main.yml) [![codecov](https://codecov.io/gh/francis94c/branch_sdk/branch/master/graph/badge.svg?token=KCPSZJHEO9)](https://codecov.io/gh/francis94c/branch_sdk) [![pub package](https://img.shields.io/pub/v/branch_sdk.svg)](https://pub.dev/packages/branch_sdk) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

![Branch](https://github.com/francis94c/branch_sdk/blob/master/assets/images/branch.png?raw=true)

This plugin is a wrapper for the [Branch](https://branch.io) SDK.

It currently supports Android and iOS.

## Getting started

Add the below to your `pubspec.yaml` file.

```yaml
dependencies:
  branch_sdk: ^1.0.0-alpha.1
```

and import with

```dart
import 'package:branch_sdk/branch_sdk.dart';
```

## Usage

### Basic Integration

To basically setup the Branch SDK you need to follow the below instructions based on platform of choice.

#### iOS

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

To verify your integration, do the following: Note, this work for iOS only.

```dart
import 'package:branch_sdk/branch_sdk.dart';

BranchSdk.init();

BranchSdk.validateSDKIntegration();
```