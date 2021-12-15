#import "BranchSdkPlugin.h"
#if __has_include(<branch_sdk/branch_sdk-Swift.h>)
#import <branch_sdk/branch_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "branch_sdk-Swift.h"
#endif

@implementation BranchSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBranchSdkPlugin registerWithRegistrar:registrar];
}
@end
