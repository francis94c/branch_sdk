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
            initBranch(call, result)
        case "validateSDKIntegration":
            Branch.getInstance().validateSDKIntegration()
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "enableLogging":
            Branch.getInstance().enableLogging()
        case "setIdentity":
            Branch.getInstance().setIdentity(call.arguments as? String) { (referral: [AnyHashable : Any]?, error: Error?) -> () in
                result(true)
            }
        case "logout":
            Branch.getInstance().logout()
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func initBranch(_ call: FlutterMethodCall, _ result: FlutterResult) {
        Branch.getInstance()
        if let args = call.arguments as? Dictionary<String, Any> {
            let debug = args["debug"] as? Bool
            if (debug == true) {
                Branch.getInstance().enableLogging()
            }
        }
        result(true)
    }
}
