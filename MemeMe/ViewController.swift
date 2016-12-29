import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MemeTextChangedListener {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textTop: UITextField!
    @IBOutlet weak var textBottom: UITextField!
    @IBOutlet weak var buttonCamera: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var buttonShare: UIBarButtonItem!
    private let imageKey : String = "UIImagePickerControllerOriginalImage"
    private var memeTopTextFieldDelegate : MemeTextFieldDelegate!
    private var memeBottomTextFieldDelegate : MemeTextFieldDelegate!
    var memeToEdit : Meme!

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeLayout()
        listenToMemeTextChanges()
        toggleCameraButtonBasedOnCameraAvailability()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onClickCancelButton(_ sender: Any) {
        dismissImagePicker()
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
        self.imageView.image = image
        buttonShare.isEnabled = true
        dismissImagePicker()
    }

    func onMemeTextChangeStarted(_ height : CGFloat) {
        self.view.frame.origin.y -= height
    }

    func onMemeTextChangeEnd(_ height : CGFloat) {
         self.view.frame.origin.y += height
    }

    @IBAction func onClickShareButton(_ sender: Any) {
        let imageMeme : UIImage = generateMemeImage()
        let activityViewController : UIActivityViewController = UIActivityViewController (activityItems: [imageMeme], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {
            (s, ok, items, error) in
            self.saveMeme(withImage: imageMeme)
            self.dismiss(animated: true, completion: nil  )
        }
        present(activityViewController, animated: true, completion: nil)
    }

    private func openImagePicker(for sourceType : UIImagePickerControllerSourceType) {
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

    private func listenToMemeTextChanges() {
        memeBottomTextFieldDelegate = MemeTextFieldDelegate(self as MemeTextChangedListener, enableKeyboardToggleNotifications: true)
        memeTopTextFieldDelegate = MemeTextFieldDelegate(self as MemeTextChangedListener, enableKeyboardToggleNotifications: false)
        textTop.delegate = memeTopTextFieldDelegate
        textBottom.delegate = memeBottomTextFieldDelegate
    }

    private func toggleCameraButtonBasedOnCameraAvailability() {
        buttonCamera.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
    }

    private func initializeMemeTextsWithImpactfulStyle() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let memeTextAttributes = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -3.0,
            NSParagraphStyleAttributeName: paragraphStyle
            ] as [String : Any]
        textTop.defaultTextAttributes = memeTextAttributes
        textBottom.defaultTextAttributes = memeTextAttributes
        textTop.text = (memeToEdit == nil) ? "TOP" : memeToEdit.topText
        textBottom.text = (memeToEdit == nil) ? "BOTTOM" : memeToEdit.bottomText
    }

    private func initializeLayout() {
        initializeMemeImage()
        initializeMemeTextsWithImpactfulStyle()
        initializeButtonShareEnabledState()
    }

    private func initializeButtonShareEnabledState() {
        if (memeToEdit == nil) {
            buttonShare.isEnabled = false
        } else {
            buttonShare.isEnabled = true
        }
    }

    private func initializeMemeImage() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = (memeToEdit == nil) ? nil : memeToEdit.memeImageOriginal
    }

    private func generateMemeImage() -> UIImage {
        hideToolbars(true)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        hideToolbars(false)
        return memedImage
    }

    private func hideToolbars(_ shouldHideToolbars : Bool) {
        toolbar.isHidden = shouldHideToolbars
        topToolbar.isHidden = shouldHideToolbars
    }

    private func saveMeme(withImage image : UIImage) {
        let meme : Meme = Meme(topText: textTop.text!, bottomText: textBottom.text!, memeImageOriginal: imageView.image!, memeImage: image)
        MemesRepository.getInstance().insert(meme)
    }
}
