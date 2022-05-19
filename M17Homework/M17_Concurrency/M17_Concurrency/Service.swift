//
//  ViewModel.swift
//  M17TableView
//
//  Created by Maxim NIkolaev on 01.12.2021.
//

import UIKit

struct Service {
    
    func loadImage(urlString: String) -> UIImage? {
        guard let file = URL(string: urlString), let data = try? Data(contentsOf: file) else
        {
            print("Ошибка, не удалось загрузить изображение")
            return nil
        }
        return UIImage(data: data)
    }
    
    func getImageURL(completion: @escaping (String?, Error?) -> Void) {
        let file = URL(string: "https://aws.random.cat/meow")
        let task = URLSession.shared.dataTask(with: file!) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            let someDictionaryFromJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            let imageModel = ImageModel(dictionary: someDictionaryFromJSON!)
            completion(imageModel?.file, error)
        }
        task.resume()
    }
}

