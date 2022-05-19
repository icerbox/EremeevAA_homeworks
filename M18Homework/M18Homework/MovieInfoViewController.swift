import UIKit

class MovieInfoViewController: UIViewController {
    
    // Объявляем переменную, в которую передается текущая выбранная строка из ViewController'a
    var rowSelected: APIResponseResults?
    
    var imageSelected: Images?
    
    // Объявляем имэджвью для картинки в левой ячейке
    
    lazy var cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // Объявляем лейбл для хидера
    
    lazy var cellTitle: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.blackFont
        label.font = Constants.Fonts.ui16Semi
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // Объявляем лейбл для основного текста
    
    lazy var cellDescription: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.blackFont
        label.font = Constants.Fonts.ui14Regular
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
        
    // Добавляем стэквью для ячейки с двумя лейблами
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.addArrangedSubview(cellImage)
        stackView.addArrangedSubview(cellTitle)
        stackView.addArrangedSubview(cellDescription)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Viewmodel configuration
    
    //Настраиваем вьюмодель. Указываем соответствие нашего имэджвью и лейблов данным из структуры, которая объявлена в ViewModel.swift

    func configure(_ viewModel: APIResponseResults, _ imageModel: Images) {
        cellImage.image = imageSelected?.imageCell
        cellTitle.text = rowSelected?.title
        cellDescription.text = rowSelected?.description
    }
    
    // MARK: - Constraints
    
    // При помощи SnapKit устанавливаем констрейнты для двух стэквью
    
    private func setupViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(cellImage)
        stackView.addArrangedSubview(cellTitle)
        stackView.addArrangedSubview(cellDescription)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        cellImage.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.centerX.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        cellTitle.snp.makeConstraints { make in
            make.top.equalTo(cellImage.snp.bottom).offset(50)
            make.centerX.centerX.equalTo(view)
            make.height.equalTo(50)
        }
        cellDescription.snp.makeConstraints { make in
            make.top.equalTo(cellTitle.snp.bottom).offset(50)
            make.centerX.centerX.equalTo(view)
            make.height.equalTo(100)
        }
    }
}
