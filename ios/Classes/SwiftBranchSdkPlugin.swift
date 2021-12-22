import Flutter
import UIKit
import Branch

public class SwiftBranchSdkPlugin: NSObject, FlutterPlugin {
    
    var latchedLaunchOptions: [AnyHashable: Any]?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "branch_sdk", binaryMessenger: registrar.messenger())
        let instance = SwiftBranchSdkPlugin()
        
        registrar.addApplicationDelegate(instance)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let branchHandled = Branch.getInstance().application(app, open: url, options: options)
        return branchHandled
    }
    
    public func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]) -> Void) -> Bool {
        let handledByBranch = Branch.getInstance().continue(userActivity)
        return handledByBranch
    }
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        Branch.getInstance().handlePushNotification(userInfo)
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        latchedLaunchOptions = launchOptions
        return true
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
    
    /**
     Initialize the Branch SDK.
     */
    private func initBranch(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        Branch.getInstance()
        if let args = call.arguments as? Dictionary<String, Any> {
            let debug = args["debug"] as? Bool
            if (debug == true) {
                Branch.getInstance().enableLogging()
                Branch.setUseTestBranchKey(true)
            }
        }
        Branch.getInstance().initSession(launchOptions: latchedLaunchOptions) { (params, error) in
            // do stuff with deep link data (nav to page, display content, etc)
            print(params as? [String: AnyObject] ?? {})
            result(true)
        }
    }
}
