import Foundation

class MemesRepository {
    private static var instance : MemesRepository!
    private var memeCollection : [Meme] = []

    public static func getInstance() -> MemesRepository {
        if (instance != nil ) {
            return instance
        }
        instance = MemesRepository()
        return instance
    }

    public func loadAll() -> [Meme] {
        return memeCollection
    }

    public func insert(_ meme : Meme) {
        memeCollection.append(meme)
    }
}
