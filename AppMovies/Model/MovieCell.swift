//
//  MovieCollectionViewCell.swift
//  AppMovies
//
//  Created by nathan on 31/05/2021.
//

import UIKit

class MovieCell: UITableViewCell {

    
    
    @IBOutlet weak var poster: UIImageView!
    //@IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInformation(movie: Movie) {
        title.text = movie.title
        overview.text = movie.overview
    }
    
    
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async() {
            self.poster.image = image
        }
    }

}
