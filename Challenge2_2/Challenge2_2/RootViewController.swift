import UIKit

class RootViewController: UIViewController {
  
  private let padding: CGFloat = 50.0
  
  private let greenView: UIView = {
    let view = UIView()
    view.backgroundColor = .green
    return view
  }()
  
  private let redView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  override func viewWillLayoutSubviews() {
    setupConstraints()
  }
  
  private func setupViews() {
    view.addSubview(greenView)
    greenView.addSubview(redView)
  }
  
  private func setupConstraints() {
    view.backgroundColor = .yellow
    greenView.translatesAutoresizingMaskIntoConstraints = false
    redView.translatesAutoresizingMaskIntoConstraints = false
    redView.clipsToBounds = true
    greenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
    greenView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
    greenView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding).isActive = true
    greenView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding).isActive = true
    redView.centerXAnchor.constraint(equalTo: greenView.centerXAnchor).isActive = true
    redView.centerYAnchor.constraint(equalTo: greenView.centerYAnchor).isActive = true
    redView.leadingAnchor.constraint(equalTo: greenView.leadingAnchor, constant: padding/2).isActive = true
    redView.trailingAnchor.constraint(equalTo: greenView.trailingAnchor, constant: -padding/2).isActive = true
    redView.heightAnchor.constraint(equalToConstant: padding*2).isActive = true
  }
}

