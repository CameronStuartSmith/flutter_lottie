import UIKit
import Flutter
import Lottie


public class LottieViewFactory : NSObject, FlutterPlatformViewFactory {
   var animationView: LOTAnimationView?
   var registrarInstance : FlutterPluginRegistrar
   
   init(registrarInstance : FlutterPluginRegistrar) {
      self.registrarInstance = registrarInstance
      super.init()
   }
   
   public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
      return FlutterStandardMessageCodec.sharedInstance()
   }
   
   public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
      return LottieView(frame, viewId: viewId, args: args, registrarInstance: registrarInstance)
   }
}

