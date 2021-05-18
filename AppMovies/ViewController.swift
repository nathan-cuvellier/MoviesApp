//
//  ViewController.swift
//  AppMovies
//
//  Created by nathan on 13/04/2021.
//

import UIKit

class ViewController: UIViewController {

    private let categoryRepository = CategoryRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        categoryRepository.getCategories() { response in
            if let categories = response {
                print(categories)
            }
        }
    }


}

