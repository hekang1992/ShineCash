import Contacts
import ContactsUI
import Flutter

public class ContactHandler: NSObject, CNContactPickerDelegate {
    private let contactStore = CNContactStore()
    var singleSelectResult: FlutterResult?

    public func getAllContacts(result: @escaping FlutterResult) {
        checkContactAuthorization { [weak self] granted in
            guard granted else {
                self?.showPermissionAlert()
                result(
                    FlutterError(
                        code: "404",
                        message: "404",
                        details: nil))
                return
            }

            let keys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey]
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            var contacts = [[String: String]]()

            do {
                try self?.contactStore.enumerateContacts(with: request) { contact, _ in
                    let name =
                        self?.formatName(family: contact.familyName, given: contact.givenName) ?? ""

                    var phoneNumbers = [String]()
                    for phone in contact.phoneNumbers {
                        let number = phone.value.stringValue
                            .replacingOccurrences(
                                of: "[^0-9+]", with: "", options: .regularExpression)
                        phoneNumbers.append(number)
                    }

                    let phoneNumbersString = phoneNumbers.joined(separator: ",")

                    if !phoneNumbersString.isEmpty {
                        contacts.append(["pens": name, "ever": phoneNumbersString])
                    }
                }
                result(contacts)
            } catch {
                result(
                    FlutterError(
                        code: "FETCH_FAILED",
                        message: error.localizedDescription,
                        details: nil))
            }
        }
    }

    public func pickSingleContact(result: @escaping FlutterResult) {
        checkContactAuthorization { [weak self] granted in
            guard granted else {
                self?.showPermissionAlert()
                result(
                    FlutterError(
                        code: "PERMISSION_DENIED",
                        message: "PERMISSION_DENIED",
                        details: nil))
                return
            }

            self?.singleSelectResult = result
            let picker = CNContactPickerViewController()
            picker.delegate = self
            picker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")

            DispatchQueue.main.async {
                if let controller = UIApplication.shared.keyWindow?.rootViewController {
                    controller.present(picker, animated: true)
                }
            }
        }
    }

    public func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact)
    {
        let name = formatName(family: contact.familyName, given: contact.givenName)
        let phone =
            contact.phoneNumbers.first?.value.stringValue
            .replacingOccurrences(of: "[^0-9+]", with: "", options: .regularExpression) ?? ""

        singleSelectResult?(["pens": name, "ever": phone])
        singleSelectResult = nil
    }

    public func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        singleSelectResult?(nil)
        singleSelectResult = nil
    }

    private func checkContactAuthorization(completion: @escaping (Bool) -> Void) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .notDetermined:
            contactStore.requestAccess(for: .contacts) { granted, error in
                DispatchQueue.main.async {
                    completion(granted && (error == nil))
                }
            }
        case .authorized:
            completion(true)
        case .limited:
            completion(true)
        default:
            completion(false)
        }
    }

    private func showPermissionAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Permission denied",
                message: "Please go to settings to enable the permission.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(
                UIAlertAction(
                    title: "Settings", style: .default,
                    handler: { _ in
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url)
                        }
                    }))

            if let controller = UIApplication.shared.keyWindow?.rootViewController {
                controller.present(alert, animated: true)
            }
        }
    }

    private func formatName(family: String, given: String) -> String {
        return "\(given) \(family)".trimmingCharacters(in: .whitespaces)
    }
}
