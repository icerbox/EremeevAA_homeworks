//
//  NetworkService.swift
//  MVPpattern
//
//  Created by Михаил on 17.05.2022.
//

import UIKit

protocol NetworkCommentServiceProtocol {
    func getMovies (searchText: String, completion: @escaping (Result<MovieStats?, Error>) -> Void)

}
 
class CommentService: NetworkCommentServiceProtocol {
        func getMovies(searchText: String, completion: @escaping (Result<MovieStats?, Error>) -> Void) {
//            let urlString = "https://jsonplaceholder.typicode.com/posts"
            let urlString = "https://imdb-api.com/en/API/Search/k_u6h4msc9/\(searchText)"
            guard let url = URL(string: urlString) else {
                return
            }
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                do {
                    let obj = try JSONDecoder().decode(MovieStats.self, from: data!)
//                    DispatchQueue.main.async {
//                      MainViewController.activityIndicator.stopAnimating()
//                    }
                    completion(.success(obj))
                } catch {
                    completion(.failure(error))
                }
                
            }.resume()
            
        }
    
}
