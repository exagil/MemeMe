import UIKit

class MemeDetailViewController: UIViewController {
    @IBOutlet weak var imageMeme: UIImageView!
    @IBOutlet weak var textTop: UITextField!
    @IBOutlet weak var textBottom: UITextField!
    @IBOutlet weak var buttonEdit: UIBarButtonItem!
    public var meme : Meme!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
