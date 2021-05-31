//
//  ImageManager.swift
//  AppMovies
//
//  Created by nathan on 31/05/2021.
//

import Foundation
import UIKit

class ImageManager {
    var imageCache: [String: UIImage] = [:]
    
    func getImageInCache(url: URL, completion: @escaping ((UIImage, String) -> Void)) {
        guard let image = imageCache[url.absoluteString] else {
            RequestManager.shared.requestData(url: url) { data in
                if let image = UIImage(data: data) {
                    self.imageCache[url.absoluteString] = image
                    completion(image, url.absoluteString)
                }
            }
            return
        }
        completion(image, url.absoluteString)
    }
}
