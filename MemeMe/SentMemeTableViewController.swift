import UIKit

class SentMemeTableViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableMemes: UITableView!
    var memes : [Meme] = [Meme]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableMemes.dataSource = self
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
}
