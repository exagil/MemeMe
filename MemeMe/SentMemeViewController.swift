import UIKit

class SentMemeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(onClickNewMemeButton))
    }
    
    func onClickNewMemeButton() {
        let memeViewController : EditMemeViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditMemeViewController") as! EditMemeViewController
        present(memeViewController, animated: true, completion: nil)
    }
}
