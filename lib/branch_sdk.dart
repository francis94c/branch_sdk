import 'dart:async';

import 'package:flutter/services.dart';

class BranchSdk {
  static const MethodChannel _channel = MethodChannel('branch_sdk');

  /// Get platform version. Boilerplate Flutter plugin function.
  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// Initailize the Branch SDK.
  static init({bool? debug, Function? onInit}) async {
    var params = {};

    if (debug == true) {
      params['debug'] = true;
    }

    bool result = await _channel.invokeMethod('init', params);

    if (result) {
      onInit?.call();
    }
  }

  /// Clears user session and creates a new one. Use this when another user
  /// wants to use the app.
  static void logout(Function? logoutCallback) async {
    if (logoutCallback != null) {
      bool result = await _channel.invokeMethod('logout', [
        {"logoutCallback": true}
      ]);
      if (result) {
        logoutCallback();
      }
    } else {
      await _channel.invokeMethod('logout');
    }
  }

  static void setIdentity(String identity) async {
    await _channel.invokeMethod('setIdentity', identity);
  }

  /// Enable Branch SDK Logging.
  static void enableLogging() async {
    await _channel.invokeMethod('enableLogging');
  }

  /// wrapper method to add the pre-install campaign analytics
  static void setPreinstallCampaign(String? campaign) async {
    await _channel.invokeMethod('setPreinstallCampaign', [
      {"preinstallCampaign": campaign}
    ]);
  }

  /// wrapper method to add the pre-install campaign analytics
  static void setPreinstallPartner(String? partner) async {
    await _channel.invokeMethod('setPreinstallPartner', [
      {"preInstallPartner": partner}
    ]);
  }

  /// Use the `validateSDKIntegration` method as a debugging aid to assure that
  /// you've integrated the Branch SDK correctly.
  static validateSDKIntegration() {
    _channel.invokeMethod('validateSDKIntegration');
  }
}
