#import "UtilPlugin.h"
#import <util_plugin/util_plugin-Swift.h>

@implementation UtilPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUtilPlugin registerWithRegistrar:registrar];
}
@end
