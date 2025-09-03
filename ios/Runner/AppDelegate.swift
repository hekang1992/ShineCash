import FBSDKCoreKit
import Flutter
import Foundation
import MachO
import NetworkExtension
import StoreKit
import UIKit

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
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(
            name: "shineapp_info",
            binaryMessenger: controller.binaryMessenger)
        let contactHandler = ContactHandler()
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == "getPlatformLanguage" {
                let locale = Locale.current
                let languageCode = locale.languageCode ?? "en"
                result(languageCode)
            } else if call.method == "isVpnActive" {
                self.isVpnActive { isActive in
                    result(isActive)
                }
            } else if call.method == "googleMarket" {
                self.googleMarket(call: call)
            } else if call.method == "openCamera" {
                if let args = call.arguments as? [String: Any],
                    let type = args["type"] as? String
                {
                    CameraManager.shared.presentCamera(from: controller, type: type) { imageData in
                        if let imageData = imageData {
                            result(FlutterStandardTypedData(bytes: imageData))
                        }
                    }
                }
            } else if call.method == "openGallery" {
                PhotoLibraryManager.shared.presentPhotoLibrary(from: controller) { imageData in
                    if let imageData = imageData {
                        result(FlutterStandardTypedData(bytes: imageData))
                    }
                }
            } else if call.method == "getAllContacts" {
                contactHandler.getAllContacts(result: result)
            } else if call.method == "pickSingleContact" {
                contactHandler.pickSingleContact(result: result)
            } else if call.method == "to_appstroe" {
                if let scene = UIApplication.shared.connectedScenes.first(where: {
                    $0.activationState == .foregroundActive
                }) as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
            } else if call.method == "getSystemInfo" {
                let systemInfo = self.getSystemInfo()
                result(systemInfo)
            } else {
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
            ApplicationDelegate.shared.application(
                UIApplication.shared, didFinishLaunchingWithOptions: nil)
        } else {

        }
    }

    func getSystemInfo() -> [String: String] {
        var result = [String: String]()

        let storage = StorageInfo.getVolumeCapacity()
        result["scornfully"] = "\(storage.free)"
        result["plot"] = "\(storage.total)"

        let vmStats = getMemoryInBytes()
        result["base"] = String(vmStats.total)
        result["spirit"] = String(vmStats.free)

        return result
    }

    func getMemoryInBytes() -> (total: UInt64, free: UInt64, used: UInt64) {
        var totalMemory: UInt64 = 0
        var freeMemory: UInt64 = 0
        var usedMemory: UInt64 = 0

        let hostPort = mach_host_self()
        var hostSize = mach_msg_type_number_t(
            MemoryLayout<vm_statistics_data_t>.size / MemoryLayout<integer_t>.size)
        var pageSize: vm_size_t = 0
        host_page_size(hostPort, &pageSize)

        var vmStat = vm_statistics_data_t()
        let status = withUnsafeMutablePointer(to: &vmStat) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(hostSize)) {
                host_statistics(hostPort, HOST_VM_INFO, $0, &hostSize)
            }
        }

        if status == KERN_SUCCESS {
            totalMemory = ProcessInfo.processInfo.physicalMemory
            let free = UInt64(vmStat.free_count) * UInt64(pageSize)
            let inactive = UInt64(vmStat.inactive_count) * UInt64(pageSize)
            freeMemory = free + inactive
            let active = UInt64(vmStat.active_count) * UInt64(pageSize)
            let wired = UInt64(vmStat.wire_count) * UInt64(pageSize)
            usedMemory = active + wired
        }

        return (totalMemory, freeMemory, usedMemory)
    }

}

struct StorageInfo {
    static func getVolumeCapacity() -> (total: String, free: String) {
        // 正确创建 URL
        let homeDirectoryURL = URL(fileURLWithPath: NSHomeDirectory())
        
        do {
            let values = try homeDirectoryURL.resourceValues(forKeys: [.volumeTotalCapacityKey, .volumeAvailableCapacityKey])
            
            guard let total = values.volumeTotalCapacity,
                  let available = values.volumeAvailableCapacity else {
                return ("0", "0")
            }
            
            return (String(total), String(available))
            
        } catch {
            print("error: \(error.localizedDescription)")
            return ("0", "0")
        }
    }
}
