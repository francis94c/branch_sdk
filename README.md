# branch_sdk

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

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

Add the below to your `Info.plist` file

```xml
<key>branch_key</key>
<string>key_live_or_test</string>
```
