//
//  SecondaryPresenter.swift
//  MVPpattern
//
//  Created by Михаил on 15.05.2022.
//

import Foundation
import UIKit
// input protocol
protocol SecondaryViewProtocol: AnyObject {
    func setMovie(movie: Results?)
}
//output protocol
protocol SecondaryViewPresenterProtocol: AnyObject {
    init(view: SecondaryViewProtocol, networkService: NetworkMovieServiceProtocol, movie: Results?, image: UIImage)
    func setMovie()
    var image: UIImage {get}
}

class SecondaryPresenter: SecondaryViewPresenterProtocol {
    
    
    weak var view: SecondaryViewProtocol?
    let networkService: NetworkMovieServiceProtocol!
    var movie: Results?
    var image: UIImage
    
    required init(view: SecondaryViewProtocol, networkService: NetworkMovieServiceProtocol, movie: Results?, image: UIImage) {
        self.view = view
        self.networkService = networkService
        self.movie = movie
        self.image = image
    }
    
    public func setMovie() {
        self.view?.setMovie(movie: movie)
    }
    
    
}
