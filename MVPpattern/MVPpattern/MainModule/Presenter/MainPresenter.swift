//
//  MainPresenter.swift
//  MVPpattern
//
//  Created by Михаил on 09.05.2022.
//

import Foundation


protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
    var searchText: String { get set }
}

protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkCommentServiceProtocol)
    func getMoviesData(searchText: String)
    var movies: MovieStats? { get set}
    
}

class MainPresenter: MainViewPresenterProtocol {
    
    
    weak var view: MainViewProtocol?
    let networkService: NetworkCommentServiceProtocol!
    var movies: MovieStats?
    
    
    
    required init(view: MainViewProtocol, networkService: NetworkCommentServiceProtocol) {
    self.view = view
    self.networkService = networkService
    getMoviesData(searchText: view.searchText)
   }

    func getMoviesData(searchText: String) {
        networkService.getMovies(searchText: searchText, completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let displayData):
                    self.movies = displayData
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        })
    }

    
}
