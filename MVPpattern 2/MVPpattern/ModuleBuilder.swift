//
//  ModuleBuilder.swift
//  MVPpattern
//
//  Created by Михаил on 09.05.2022.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func createSecondaryModule(movie: Results?, image: UIImage) -> UIViewController
}

class ModuleBuilder: Builder {
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = MovieService()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    
    static func createSecondaryModule(movie: Results?, image: UIImage) -> UIViewController {
        let view = SecondaryViewController()
        let networkService = MovieService()
        let presenter = SecondaryPresenter(view: view, networkService: networkService, movie: movie, image: image)
        view.secondaryPresenter = presenter
        return view
    }
    
    
    
}
