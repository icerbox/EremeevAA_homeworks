//
//  FileInfo.swift
//  MVVMtest
//
//  Created by Айсен Еремеев on 02.04.2023.
//

import UIKit

class FileInfo: UIView {
  
  private enum ViewMetrics {
    static let fontSize: CGFloat = 24.0
    static let spacing: CGFloat = 16.0
  }
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [imageView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = ViewMetrics.spacing
    stackView.distribution = .fillEqually
    return stackView
  }()
  
  private lazy var imageView: UIImageView = {
    var image = UIImageView()
    image.backgroundColor = .orange
    image.translatesAutoresizingMaskIntoConstraints = false
    image.layer.cornerRadius = 10
    image.layer.borderWidth = 1.0
    return image
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  private func setupView() {
    addSubview(stackView)
    NSLayoutConstraint.activate([
      layoutMarginsGuide.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
      layoutMarginsGuide.topAnchor.constraint(equalTo: stackView.topAnchor),
      layoutMarginsGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
      layoutMarginsGuide.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
    ])
  }
}
