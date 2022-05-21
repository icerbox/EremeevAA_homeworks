//
//  MainPresenter.swift
//  MVPpattern
//
//  Created by Михаил on 09.05.2022.
//

import Foundation
import UIKit

//output protocol
protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
    func getSearchBarText() -> String
}

//input protocol
protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkMovieServiceProtocol)
    func getMoviesData(searchText: String)
    var movies: MovieStats? { get set}
    var images: [UIImage]? {get}
    func getImages() -> [UIImage]
}
    


class MainPresenter: MainViewPresenterProtocol {
    var images: [UIImage]?
    
    weak var view: MainViewProtocol?
    var networkService: NetworkMovieServiceProtocol! = nil
    var movies: MovieStats?
    
    

    
    
    required init(view: MainViewProtocol, networkService: NetworkMovieServiceProtocol) {
    self.view = view
    self.networkService = networkService
   }

    func getMoviesData(searchText: String) {
        networkService.getMovies(searchText: view?.getSearchBarText() ?? "", completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let displayData):
                    self.movies = displayData
                    
                    self.images = self.getImages()
                                        
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }

    
    func getImages() -> [UIImage] {
        
        var myImages: [UIImage] = []
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        for _ in 0..<(movies?.results.count ?? 0) {
                   
        for i in self.movies?.results ?? [] {
        let urlString = i.image
        myImages.append(self.networkService.loadImage(urlString: urlString)!)
          }
        }
        dispatchGroup.leave()
        return myImages
        
    }
    
    
    
}
