import UIKit

class SentMemesCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    private let reuseIdentifier = "collectionViewMeme"
    private var memes : [Meme] = [Meme]()
    @IBOutlet weak var collectionViewMemes: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewMemes.dataSource = self
        collectionViewMemes.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        memes = MemesRepository.getInstance().loadAll()
        collectionViewMemes.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell   = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SentMemeCollectionViewCell
        cell.imageMeme.image = memes[indexPath.row].memeImage
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeDetailViewController : MemeDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        memeDetailViewController.meme = memes[indexPath.row]
        navigationController?.pushViewController(memeDetailViewController, animated: true)
    }
}
