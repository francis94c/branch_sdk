import Flutter
import UIKit
import Branch

public class SwiftBranchSdkPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "branch_sdk", binaryMessenger: registrar.messenger())
        let instance = SwiftBranchSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "init":
            Branch.getInstance()
        case "validateSDKIntegration":
            Branch.getInstance().validateSDKIntegration()
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "logout":
            Branch.getInstance().logout()
        default:
            result(FlutterMethodNotImplemented)
        }
        
    }
}
