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
        view.addSubview(commentTitleLabel)
        view.addSubview(commentBodyLabel)
        secondaryPresenter.setMovie()
        setupConstraints()
    }
    
    private lazy var commentTitleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var commentBodyLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private func setupConstraints() {
//        commentTitleLabel.backgroundColor = .cyan
//        commentBodyLabel.backgroundColor = .blue
        
    commentTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
    commentTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
    commentTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    commentTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
    commentTitleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -600)
        ])
   
    commentBodyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
    commentBodyLabel.topAnchor.constraint(equalTo: commentTitleLabel.bottomAnchor),
    commentBodyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    commentBodyLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
    commentBodyLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -450)
        ])
    }
    
    
    
    
}



extension SecondaryViewController: SecondaryViewProtocol {
    func setMovie(movie: Results?) {
        commentTitleLabel.text = movie?.title
        commentBodyLabel.text = movie?.resultDescription
    }
    
    
}
