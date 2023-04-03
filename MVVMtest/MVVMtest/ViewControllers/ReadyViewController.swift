//
//  LoginViewController.swift
//  MVVMtest
//
//  Created by Айсен Еремеев on 29.03.2023.
//

import UIKit

class ReadyViewController: UIViewController {
    var didSendEventClosure: ((ReadyViewController.Event) -> Void)?
    
    private let readyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ready", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(readyButton)
        readyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            readyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            readyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            readyButton.widthAnchor.constraint(equalToConstant: 200),
            readyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        readyButton.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)
    }
    
    deinit {
        print("ReadyViewController deinit")
    }
    
    @objc private func didTapLoginButton(_ sender: Any) {
        didSendEventClosure?(.ready)
    }
}

extension ReadyViewController {
    enum Event {
        case ready
    }
}
