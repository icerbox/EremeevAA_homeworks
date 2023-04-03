//
//  FileTableViewCell.swift
//  MVVMtest
//
//  Created by Айсен Еремеев on 02.04.2023.
//

import UIKit

protocol FileTableViewCellDelegate: AnyObject {
  // Передаем полученный токен
  func loadImage(stringUrl: String, completion : @escaping ((UIImage?) -> Void))
}

class FileTableViewCell: UITableViewCell {

  weak var delegate: FileTableViewCellDelegate?

  static let identifier = "FileTableViewCell"

  var images = [UIImage]()

  lazy var fileImage: UIImageView = {
      let imageView = UIImageView()
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.contentMode = .scaleAspectFit
      return imageView
  }()

  private lazy var fileName: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.lineBreakMode = .byWordWrapping
      label.numberOfLines = 0
      return label
  }()

  private lazy var fileSize: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.lineBreakMode = .byWordWrapping
      label.numberOfLines = 0
      return label
  }()


    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
//        stackView.backgroundColor = .systemGreen
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.contentMode = .scaleAspectFill
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        stackView.addArrangedSubview(fileImage)
        stackView.addArrangedSubview(fileName)
        stackView.addArrangedSubview(fileSize)
        return stackView
    }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
//    contentView.backgroundColor = .orange
    contentView.addSubview(stackView)
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    fileImage.image = nil
  }

    func configure(_ viewModel: DiskFile) {
    // В лейбл fileName добавляем название полученной картинки
      delegate?.loadImage(stringUrl: viewModel.preview!) {
//        print("Добавлено изображение: \(String(describing: $0))")
        self.fileImage.image = $0
      }
    // Раскрываем опционал размера файла
      guard let sizes = viewModel.size else { return }
      fileSize.text = String("\(sizes)")
      fileName.text = viewModel.name
}

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      fileImage.heightAnchor.constraint(equalToConstant: 50),
      fileImage.widthAnchor.constraint(equalToConstant: 50)
    ])
  }
}

