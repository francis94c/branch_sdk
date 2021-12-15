import 'dart:async';

import 'package:flutter/services.dart';

class BranchSdk {
  static const MethodChannel _channel = MethodChannel('branch_sdk');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static init() {
    _channel.invokeMethod('init');
  }

  /// Use the `validateSDKIntegration` method as a debugging aid to assure that
  /// you've integrated the Branch SDK correctly.
  static validateSDKIntegration() {
    _channel.invokeMethod('validateSDKIntegration');
  }
}
