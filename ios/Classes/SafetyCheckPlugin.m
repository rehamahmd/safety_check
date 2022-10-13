#import "SafetyCheckPlugin.h"
#if __has_include(<safety_check/safety_check-Swift.h>)
#import <safety_check/safety_check-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "safety_check-Swift.h"
#endif

@implementation SafetyCheckPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSafetyCheckPlugin registerWithRegistrar:registrar];
}
@end
