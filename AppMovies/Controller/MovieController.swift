//
//  Movie.swift
//  AppMovies
//
//  Created by nathan on 01/06/2021.
//

import UIKit

class MovieController: UIViewController {
    
    var movieId : Int = 0
    var movie : Movie?
    //var image : [String : UIImage] = [:]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var runtime: UILabel!
    
    private let movieRepository = MovieRepository()
    private let imageManager = ImageManager()
    
    private let identifier = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieRepository.getMovieById(movieId: movieId, completion: { response in
            if let movie = response {
                DispatchQueue.main.async {
                    self.titleLabel.text = movie.title
                    self.overview.text = movie.overview
                    
                    var genres = ""
                    movie.genres?.forEach { genre in
                        genres += genre.name + " | "
                    }
                    
                    self.genreLabel.text = String(genres.dropLast(2))
                    
                    let format = DateFormatter()
                    format.dateFormat = "yyyy-MM-dd"
                    
                    if let releaseDate = movie.releaseDate,
                    let date = format.date(from: releaseDate)
                    {
                        
                        format.dateFormat = "dd/MM/yyyy"
                        
                        self.releaseDate.text = format.string(from: date)
                    }
                    
                    if var runtimeData = movie.runtime {
                        let hours = Int(floor(Double(runtimeData) / 60))
                        
                        runtimeData -= hours * 60
                        
                        let minutes = runtimeData
                        
                        self.runtime.text = "  \(hours)h \(minutes)m"
                    }
                    
                    
                }
                
            }
        })
        
    }
    
}
