import UIKit
import SnapKit

// Объявляем класс ExecutorsCells который содержит лейблы которые отображаются на главной странице

class ExecutorsCell: UITableViewCell {
    
    static let identifier = "ExecutorsTableViewCell"
    
    let firstViewController = ViewController()
    
    var models = [Executor]()
    
    lazy var stackView: UIStackView = {
       let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addArrangedSubview(lastName)
        view.addArrangedSubview(name)
        return view
    }()
    
    lazy var stackView2: UIStackView = {
       let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addArrangedSubview(country)
        view.addArrangedSubview(dateOfBirth)
        return view
    }()
        
    let lastName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    let country: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let dateOfBirth: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
        
    public func configure() {
        contentView.addSubview(stackView)
        contentView.addSubview(stackView2)
        setupConstraints()
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.right.equalTo(contentView)
            make.left.equalTo(contentView)
            make.bottom.equalTo(stackView2.snp.top).offset(-10)
        }
        stackView2.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.right.equalTo(contentView)
            make.left.equalTo(contentView)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
}
