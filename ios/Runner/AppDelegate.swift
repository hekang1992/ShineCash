import Flutter
import UIKit
import NetworkExtension

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        fluttetToSwift()
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

extension AppDelegate {
    
    private func fluttetToSwift() {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "shineapp_info",
                                           binaryMessenger: controller.binaryMessenger)
        
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == "getPlatformLanguage" {
                let locale = Locale.current
                let languageCode = locale.languageCode ?? "en"
                result(languageCode)
            }else if call.method == "isVpnActive" {
                self.isVpnActive { isActive in
                    result(isActive)
                }
            }
            else {
                result(FlutterMethodNotImplemented)
            }
        })
        
    }
    
    private func isVpnActive(completion: @escaping (Bool) -> Void) {
        if #available(iOS 9.0, *) {
          NEVPNManager.shared().loadFromPreferences { _ in
            let isActive = NEVPNManager.shared().connection.status == .connected
            completion(isActive)
          }
        } else {
          completion(false)
        }
      }
    
    
}
