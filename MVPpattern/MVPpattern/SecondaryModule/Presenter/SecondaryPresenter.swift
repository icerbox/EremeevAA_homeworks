//
//  SecondaryPresenter.swift
//  MVPpattern
//
//  Created by Михаил on 15.05.2022.
//

import Foundation
// input protocol
protocol SecondaryViewProtocol: AnyObject {
    func setMovie(movie: Results?)
}
//output protocol
protocol SecondaryViewPresenterProtocol: AnyObject {
    init(view: SecondaryViewProtocol, networkService: NetworkCommentServiceProtocol, movie: Results?)
    func setMovie()
}

class SecondaryPresenter: SecondaryViewPresenterProtocol {
    
    weak var view: SecondaryViewProtocol?
    let networkService: NetworkCommentServiceProtocol!
    var movie: Results?
    
    required init(view: SecondaryViewProtocol, networkService: NetworkCommentServiceProtocol, movie: Results?) {
        self.view = view
        self.networkService = networkService
        self.movie = movie
    }
    
    public func setMovie() {
        self.view?.setMovie(movie: movie)
    }
    
    
}
