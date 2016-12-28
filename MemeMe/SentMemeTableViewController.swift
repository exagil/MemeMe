import UIKit

class SentMemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableMemes: UITableView!
    var memes : [Meme] = [Meme]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableMemes.dataSource = self
        tableMemes.delegate = self
    }

     override func viewWillAppear(_ animated: Bool) {
        memes = MemesRepository.getInstance().loadAll()
        tableMemes.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCellMeme : MemeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableCellMeme") as! MemeTableViewCell
        let meme = memes[indexPath.row]
        tableCellMeme.textLabel!.text = meme.topText + "..." + meme.bottomText
        tableCellMeme.imageView?.image = meme.memeImage
        return tableCellMeme
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailViewController : MemeDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        memeDetailViewController.meme = memes[indexPath.row]
        navigationController?.pushViewController(memeDetailViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            memes.remove(at: indexPath.row)
            MemesRepository.getInstance().remove(indexPath.row)
            tableView.reloadData()
        }
    }
}
