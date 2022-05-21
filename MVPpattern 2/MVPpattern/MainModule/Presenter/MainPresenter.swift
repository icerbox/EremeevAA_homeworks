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
    init(view: MainViewProtocol, networkService: NetworkCommentServiceProtocol)
    func getMoviesData(searchText: String)
    var movies: MovieStats? { get set}
    var images: [UIImage]? {get}
}
    


class MainPresenter: MainViewPresenterProtocol {
    
    var images: [UIImage]?
    
   
    
    weak var view: MainViewProtocol?
    var networkService: NetworkCommentServiceProtocol! = nil
    var movies: MovieStats?
    

    
    
    required init(view: MainViewProtocol, networkService: NetworkCommentServiceProtocol) {
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
                    
//                for i in self.movies?.results ?? [] {
//                    let urlString = i.image
//                    self.images?.append(self.networkService.loadImage(urlString: urlString)!)
//                      }
//                      print("Images has been loaded")
                    
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }

    
}
