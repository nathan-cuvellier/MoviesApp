//
//  ViewController.swift
//  AppMovies
//
//  Created by nathan on 13/04/2021.
//

import UIKit

class ViewController: UIViewController {

    private let genreRepository = GenreRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        genreRepository.getGenres() { response in
            if let genres = response {
                print(genres)
            }
        }
    }


}

