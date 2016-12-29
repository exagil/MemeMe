import UIKit

class MemeDetailViewController: UIViewController {
    @IBOutlet weak var imageMeme: UIImageView!
    @IBOutlet weak var buttonEdit: UIBarButtonItem!
    public var meme : Meme!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageMeme.image = meme.memeImage
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onClickEdit))
    }

    func onClickEdit() {
        let editMemeViewController : EditMemeViewController = storyboard?.instantiateViewController(withIdentifier: "EditMemeViewController") as! EditMemeViewController
        print(meme.memeImageOriginal)
        editMemeViewController.memeToEdit = meme
        present(editMemeViewController, animated: true, completion: nil)
    }
}
