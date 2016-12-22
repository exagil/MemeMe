import Foundation
import UIKit

class MemeTextFieldDelegate : NSObject,  UITextFieldDelegate {
    var listener : MemeTextChangedListener
    var enableKeyboardToggleNotifications : Bool

    init(_ listener : MemeTextChangedListener, enableKeyboardToggleNotifications : Bool) {
        self.listener = listener
        self.enableKeyboardToggleNotifications = enableKeyboardToggleNotifications
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        if (enableKeyboardToggleNotifications) {
            NotificationCenter.default.addObserver(self , selector: #selector(keyboardDidShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self , selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true 
    }

    func keyboardDidShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            listener.onMemeTextChangeStarted(keyboardSize.height)
        }
    }

    func keyboardWillHide(notification : NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            listener.onMemeTextChangeEnd(keyboardSize.height)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
}
