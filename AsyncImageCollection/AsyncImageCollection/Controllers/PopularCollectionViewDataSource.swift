//
//  PopularCollectionViewDataSource.swift
//  AsyncImageCollection
//
//  Created by Del Giudice, Marco on 10/06/21.
//

import Foundation
import UIKit

class PopularCollectionViewDataSource: NSObject, UICollectionViewDataSource{
    
    var movies: [Movie]?
    var operationQueueHandler: NetworkImageOperationQueueHandler
    
    init(operationQueueHandler: NetworkImageOperationQueueHandler) {
        self.operationQueueHandler = operationQueueHandler
    }
    
    //MARK: DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
        guard let movie = movies?[indexPath.item], let url =  getPosterImageUrl(from: movie) else { return cell }
        let downloadOp = NetworkImageOperation(url: url) { (downloadedImage) in
            self.setImage(cell, downloadedImage)
        }
        operationQueueHandler.addOperationToQueue(downloadOp, indexPath)
        return cell
    }
    
    fileprivate func setImage(_ cell: PosterCollectionViewCell, _ downloadedImage: UIImage?) {
        DispatchQueue.main.async {
            cell.image = downloadedImage
        }
    }
    
    private func getPosterImageUrl(from movie: Movie) -> URL? {
        let stringURL = KeylessURL.getPosterImage(posterPath: movie.poster_path ?? "").url
        return URL(string: stringURL)
    }
}

