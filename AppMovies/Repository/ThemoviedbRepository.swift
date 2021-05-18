//
//  Themoviedb.swift
//  AppMovies
//
//  Created by nathan on 18/05/2021.
//

import Foundation

enum ApiPath : String {
    case categories = "/genre/movie/list"
    case movie = "/movie"
    case movieList = "/discover/movie"
}

struct ApiManager {
    static var shared = ApiManager()
    
    let BASE_URL = "https://api.themoviedb.org/3/"
    let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/"
    let LANGUAGE = "fr-FR"
    
    // https://betterprogramming.pub/fetch-api-keys-from-property-list-files-in-swift-4a9e092e71fa
    private var apiKey: String {
      get {
        
        guard let filePath = Bundle.main.path(forResource: "secret", ofType: "plist") else {
          fatalError("Couldn't find file 'secret.plist'.")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'secret.plist'.")
        }
        return value
      }
    }
    
    func createURL(pathUrl : ApiPath, queryParams: [URLQueryItem]? = nil) -> URLComponents? {
        var url = URLComponents(string: "\(self.BASE_URL)\(pathUrl.rawValue)")
        
        url?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: self.LANGUAGE)
        ]
        
        if let queryParams = queryParams {
            url?.queryItems! += queryParams
        }
        
        return url
    }
    
}
