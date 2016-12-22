import Foundation
import UIKit

class MemeTextFieldDelegate : NSObject,  UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true 
    }
} 
 
