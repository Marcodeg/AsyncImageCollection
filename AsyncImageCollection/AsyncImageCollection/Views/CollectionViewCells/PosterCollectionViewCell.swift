//
//  PosterCollectionViewCell.swift
//  AsyncImageCollection
//
//  Created by Del Giudice, Marco on 10/06/21.
//

import UIKit

class PosterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    var image: UIImage? {
        didSet {
            self.posterImageView.image = image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.posterImageView.contentMode = .scaleAspectFill
    }

}
