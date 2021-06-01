//
//  Category.swift
//  AppMovies
//
//  Created by nathan on 18/05/2021.
//

import UIKit

class GenreController: UIViewController {
        
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var genres: [Genre] = []
    
    private let identifier = "category_to_movies"

    private let genreRepository = GenreRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        genreRepository.getGenres() { response in
            if let genres = response {
                self.genres = genres.toGenre()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == identifier {
            let moviesController = segue.destination as! MoviesController
            if let genre = sender as? Genre {
                moviesController.genre = genre
            }
        }
    }

}

extension GenreController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.performSegue(withIdentifier: identifier, sender: genres[indexPath.item])
    }
}

extension GenreController:
    UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! GenreCollectionViewCell
        let genre = genres[indexPath.item]
        cell.setGenreLabel(genre: genre)
        
        return cell
    }
}

extension GenreController:
    
    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        return CGSize(width: (width - 20)/2, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}
