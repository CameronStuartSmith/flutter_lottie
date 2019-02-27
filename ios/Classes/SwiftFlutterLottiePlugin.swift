import Flutter
import UIKit
import Lottie

public class SwiftFlutterLottiePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
	let viewFactory = LottieViewFactory(registrarInstance: registrar)
	registrar.register(viewFactory, withId: "convictiontech/flutter_lottie")
  }
}
