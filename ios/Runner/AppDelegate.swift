import Flutter
import UIKit
import NetworkExtension
import FBSDKCoreKit
import StoreKit
import Foundation


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
        let contactHandler = ContactHandler()
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
            }else if call.method == "googleMarket" {
                self.googleMarket(call: call)
            }else if call.method == "openCamera" {
                if let args = call.arguments as? [String: Any],
                   let type = args["type"] as? String {
                    CameraManager.shared.presentCamera(from: controller) { imageData in
                        if let imageData = imageData {
                            result(FlutterStandardTypedData(bytes: imageData))
                        }
                    }
                }
            }else if call.method == "openGallery" {
                PhotoLibraryManager.shared.presentPhotoLibrary(from: controller) { imageData in
                    if let imageData = imageData {
                        result(FlutterStandardTypedData(bytes: imageData))
                    }
                }
            }else if call.method == "getAllContacts" {
                contactHandler.getAllContacts(result: result)
            }else if call.method == "pickSingleContact" {
                contactHandler.pickSingleContact(result: result)
            }else if call.method == "to_appstroe" {
                if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
            }else if call.method == "getSystemInfo" {
                let systemInfo = self.getSystemInfo()
                result(systemInfo)
            }else {
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
    
    private func googleMarket(call: FlutterMethodCall) {
        if let jsonData = call.arguments as? [String: Any] {
            Settings.shared.appID = jsonData["dirty"] as? String ?? ""
            Settings.shared.clientToken = jsonData["answers"] as? String ?? ""
            Settings.shared.displayName = jsonData["taking"] as? String ?? ""
            Settings.shared.appURLSchemeSuffix = jsonData["crumpled"] as? String ?? ""
            ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
        } else {
            
        }
    }
    
    func getSystemInfo() -> [String: String] {
        var result = [String: String]()
        
        let fileManager = FileManager.default
        if let systemAttributes = try? fileManager.attributesOfFileSystem(forPath: NSHomeDirectory()) {
            if let freeSize = systemAttributes[.systemFreeSize] as? NSNumber {
                result["scornfully"] = String(freeSize.int64Value)
            }
            if let totalSize = systemAttributes[.systemSize] as? NSNumber {
                result["plot"] = String(totalSize.int64Value)
            }
        }
        
        let totalMemory = ProcessInfo.processInfo.physicalMemory
        result["base"] = String(totalMemory)
        
        let vmStats = getVMStats()
        result["spirit"] = String(vmStats.free)
        
        return result
    }

    func getVMStats() -> (free: UInt64, used: UInt64) {
        var stats = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size / MemoryLayout<integer_t>.size)
        
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &stats) { pointer in
            return task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), UnsafeMutableRawPointer(pointer).assumingMemoryBound(to: integer_t.self), &count)
        }
        
        if kerr == KERN_SUCCESS {
            return (free: stats.virtual_size, used: stats.resident_size)
        }
        return (free: 0, used: 0)
    }
    
}
