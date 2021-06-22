#import "VgtsPlugin.h"
#if __has_include(<vgts_plugin/vgts_plugin-Swift.h>)
#import <vgts_plugin/vgts_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "vgts_plugin-Swift.h"
#endif

@implementation VgtsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVgtsPlugin registerWithRegistrar:registrar];
}
@end
