//
//  GenreCollectionViewCell.swift
//  AppMovies
//
//  Created by nathan on 18/05/2021.
//

import Foundation
import UIKit

class GenreCollectionViewCell : UICollectionViewCell {
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5
    }
    
    func setGenreLabel(genre: Genre) {
        categoryLabel.text = genre.name
    }
    
}
