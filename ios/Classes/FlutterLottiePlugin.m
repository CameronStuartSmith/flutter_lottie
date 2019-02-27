#import "FlutterLottiePlugin.h"
#import <flutter_lottie/flutter_lottie-Swift.h>

@implementation FlutterLottiePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterLottiePlugin registerWithRegistrar:registrar];
}
@end
