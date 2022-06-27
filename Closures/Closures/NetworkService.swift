//
//  NetworkService.swift
//  Closures
//
//  Created by Андрей Антонен on 26.05.2022.
//

import Foundation

class NetworkService {
    
    // @escaping оператор - это сбегающее выражение, нужна для того, чтобы когда эта функция закончится, чтобы блок который идет после него "(String?) -> ()" задержался в памяти пока не придет ответ от сервера
    class func fetch(completion: @escaping (String?, Error?) -> ()) {
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            let jsonString = String(data: data, encoding: .utf8)
            completion(jsonString, nil)
        }
        task.resume()
    }
}
