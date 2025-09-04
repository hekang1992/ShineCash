import AVFoundation
import UIKit

class CameraManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    static let shared = CameraManager()
    private var completion: ((Data?) -> Void)?

    private override init() {}

    func presentCamera(
        from viewController: UIViewController, type: String, completion: @escaping (Data?) -> Void
    ) {
        self.completion = completion

        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.openCamera(from: viewController, type: type)
                    } else {
                        self.showSettingsAlert(from: viewController, message: "Please enable camera permissions in \("Settings").")
                        completion(nil)
                    }
                }
            }
        case .restricted, .denied:
            self.showSettingsAlert(from: viewController, message: "Please enable camera permissions in \("Settings").")
            completion(nil)
        case .authorized:
            self.openCamera(from: viewController, type: type)
        @unknown default:
            completion(nil)
        }
    }

    private func openCamera(from viewController: UIViewController, type: String) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            completion?(nil)
            return
        }

        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        if type == "1" {
            picker.cameraDevice = .front
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.hideView(in: picker.view)
            }
        } else {
            picker.cameraDevice = .rear
        }
        viewController.present(picker, animated: true, completion: nil)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
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
        let maxFileSize = 500 * 1024  // 500 KB
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
        alert.addAction(
            UIAlertAction(
                title: "Settings", style: .default,
                handler: { _ in
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }))
        vc.present(alert, animated: true, completion: nil)
    }

    private func hideView(in view: UIView) {
        for subview in view.subviews {
            if let button = subview as? UIButton,
                String(describing: button).contains("CAMFlipButton")
            {
                button.isHidden = true
            } else {
                hideView(in: subview)
            }
        }
    }

}
