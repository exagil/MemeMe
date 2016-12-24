import UIKit

class SentMemeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(onClickNewMemeButton))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onClickNewMemeButton() {
        let memeViewController : ViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeViewController") as! ViewController
        present(memeViewController, animated: true, completion: nil)
    }
}
