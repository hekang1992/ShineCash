import UIKit
import Photos

class PhotoLibraryManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let shared = PhotoLibraryManager()
    private var completion: ((Data?) -> Void)?
    
    private override init() {}
    
    func presentPhotoLibrary(from viewController: UIViewController, completion: @escaping (Data?) -> Void) {
        self.completion = completion
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    if newStatus == .authorized || newStatus == .limited {
                        self.openPhotoLibrary(from: viewController)
                    } else {
                        self.showSettingsAlert(from: viewController, message: "Please enable photo album permissions in \("Settings").")
                        completion(nil)
                    }
                }
            }
        case .restricted, .denied:
            self.showSettingsAlert(from: viewController, message: "Please enable photo album permissions in \("Settings").")
            completion(nil)
        case .authorized, .limited:
            self.openPhotoLibrary(from: viewController)
        @unknown default:
            completion(nil)
        }
    }
    
    private func openPhotoLibrary(from viewController: UIViewController) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            completion?(nil)
            return
        }
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        viewController.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            let compressedData = compressImageToUnder500KB(image)
            completion?(compressedData)
        } else {
            completion?(nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        completion?(nil)
    }
    
    private func compressImageToUnder500KB(_ image: UIImage) -> Data? {
        var compression: CGFloat = 1.0
        let maxFileSize = 500 * 1024 // 500 KB
        var imageData = image.jpegData(compressionQuality: compression)
        
        while let data = imageData, data.count > maxFileSize, compression > 0.05 {
            compression -= 0.1
            imageData = image.jpegData(compressionQuality: compression)
        }
        return imageData
    }
    
    private func showSettingsAlert(from vc: UIViewController, message: String) {
        let alert = UIAlertController(title: "Permission denied", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }))
        vc.present(alert, animated: true, completion: nil)
    }
}
