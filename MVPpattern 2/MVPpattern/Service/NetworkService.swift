//
//  NetworkService.swift
//  MVPpattern
//
//  Created by Михаил on 17.05.2022.
//

import UIKit

protocol NetworkMovieServiceProtocol {
    func getMovies (searchText: String, completion: @escaping (Result<MovieStats?, Error>) -> Void)
    func loadImage(urlString: String) -> UIImage?
}
 
class MovieService: NetworkMovieServiceProtocol {
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
                    completion(.success(obj))
                } catch {
                    completion(.failure(error))
                }
                
            }.resume()
            
        }
    
    
    func loadImage(urlString: String) -> UIImage? {
        guard
            let url = URL(string: urlString),
            let data = try? Data(contentsOf: url)
        else {
            print("Ошибка, не удалось загрузить изображение")
            return nil
        }
        
        return UIImage(data: data)
    }
    
    
}
