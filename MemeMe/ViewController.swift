import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MemeTextChangedListener {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textTop: UITextField!
    @IBOutlet weak var textBottom: UITextField!
    private let imageKey : String = "UIImagePickerControllerOriginalImage"
    private var memeTextFieldDelegate : MemeTextFieldDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        memeTextFieldDelegate = MemeTextFieldDelegate(self as MemeTextChangedListener)
        textTop.delegate = memeTextFieldDelegate
        textBottom.delegate = memeTextFieldDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func openGallery(_ sender: Any) {
         openImagePicker(for: UIImagePickerControllerSourceType.photoLibrary)
    }

    @IBAction func openCamera(_ sender: Any) {
        openImagePicker(for: UIImagePickerControllerSourceType.camera )
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismissImagePicker()
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image : UIImage = info [imageKey]  as! UIImage
        self.image.image = image  
        dismissImagePicker()
    }

    func  onMemeTextChangeStarted(_ height : CGFloat) {
        self.view.frame.origin.y -= height
    }

    func onMemeTextChangeEnd(_ height : CGFloat) {
         self.view.frame.origin.y += height
    }

     private func  openImagePicker(for sourceType : UIImagePickerControllerSourceType) {
        if (UIImagePickerController.isSourceTypeAvailable(sourceType)) {
            let uiImagePicker : UIImagePickerController = UIImagePickerController()
            uiImagePicker.allowsEditing = true
            uiImagePicker.sourceType = sourceType
            uiImagePicker.delegate = self
            present(uiImagePicker , animated: true, completion: nil )
        }
    }

    private func dismissImagePicker() {
        dismiss(animated: true, completion: nil )
    }
}
