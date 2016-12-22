import Foundation
import UIKit

protocol  MemeTextChangedListener {
    func onMemeTextChangeStarted(_ height  : CGFloat)

    func onMemeTextChangeEnd(_ height : CGFloat)
}
