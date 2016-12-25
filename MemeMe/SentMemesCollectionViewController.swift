import UIKit

class SentMemesCollectionViewController: UIViewController, UICollectionViewDataSource  {
    private let reuseIdentifier = "collectionViewMeme"
    private var memes : [Meme] = [Meme]()
    @IBOutlet weak var collectionViewMemes: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewMemes.dataSource = self
        print("SentMemesCollectionViewController#viewDidLoad")
    }

    override func viewWillAppear(_ animated: Bool) {
        memes = MemesRepository.getInstance().loadAll()
        collectionViewMemes.reloadData()
        print("SentMemesCollectionViewController#viewWillAppear")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("SentMemesCollectionViewController#numberOfItemsInSection: \(memes.count)")
        return memes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell   = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SentMemeCollectionViewCell 
        cell.imageMeme.image = memes[indexPath.row].memeImage
        print("type(of: cell): \(type(of: cell))")
        print("SentMemesCollectionViewController#cellForItemAt")
        return cell
    }
}
