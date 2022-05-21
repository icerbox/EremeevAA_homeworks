//
//  SecondaryView.swift
//  MVPpattern
//
//  Created by Михаил on 15.05.2022.
//

import UIKit

class SecondaryViewController: UIViewController {
   
    var secondaryPresenter: SecondaryViewPresenterProtocol!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(commentTitleLabel)
        view.addSubview(commentBodyLabel)
        secondaryPresenter.setMovie()
        setupConstraints()
    }
    
    private lazy var commentTitleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var commentBodyLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        var imgV = UIImageView()
        imgV.image = secondaryPresenter.image
        imgV.layer.cornerRadius = 10
        imgV.layer.borderWidth = 1.0
        return imgV
    }()
    
    private func setupConstraints() {
//        commentTitleLabel.backgroundColor = .cyan
//        commentBodyLabel.backgroundColor = .blue
        
        
    imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -150),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400)
        ])
        
    commentTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            commentTitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
    commentTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    commentTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
            commentTitleLabel.bottomAnchor.constraint(equalTo: commentBodyLabel.topAnchor, constant: 0)
        ])
   
    commentBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
    commentBodyLabel.topAnchor.constraint(equalTo: commentTitleLabel.bottomAnchor),
    commentBodyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    commentBodyLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
    commentBodyLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300)
        ])
    }
    
    
    
    
}



extension SecondaryViewController: SecondaryViewProtocol {
    func setMovie(movie: Results?) {
        commentTitleLabel.text = movie?.title
        commentBodyLabel.text = movie?.resultDescription
    }
    
    
}
