import UIKit

final class ViewControllerWithAnimator: UIViewController {
    //MARK: - Variables
    var animator: UIViewPropertyAnimator!
    
    lazy var redCar: UIImageView = {
        let redCar  = UIImageView(image: UIImage(named: "Car"))
        redCar.contentMode = .scaleAspectFit
        redCar.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        redCar.translatesAutoresizingMaskIntoConstraints = true
        redCar.center.y = view.center.y
        view.addSubview(redCar)
        return redCar
    }()
    
    var value: Int = -1
}

//MARK: - UIViewController
extension ViewControllerWithAnimator {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        button.setTitle("Animate!", for: .normal)
        button.backgroundColor = .systemBlue
        
        button.addAction(
            UIAction(handler: { [weak self] _ in
                guard let self = self else { return }
                self.value += 1
                self.change()
            }), for: .touchUpInside)
        
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)
        
        slider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        slider.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        animator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut) { [weak self, redCar] in
            guard let self = self else { return }
            redCar.center.x = self.view.frame.width
            // redCar.transform = CGAffineTransform(rotationAngle: CGFloat.pi).scaledBy(x: 0.001, y: 0.001)
        }
        
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
    }
    
    func change() {
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }
            
            switch self.value {
            case 0:
                self.redCar.transform = CGAffineTransform(scaleX: 2, y: 2)
            case 1:
                self.redCar.transform = .identity
            case 2:
                self.redCar.transform = CGAffineTransform(translationX: 256, y: 256)
            case 3:
                self.redCar.transform = .identity
            case 4:
                self.redCar.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            case 5:
                self.redCar.transform = .identity
            case 6:
                self.redCar.alpha = 0.1
                self.redCar.backgroundColor = UIColor.green
            case 7:
                self.redCar.alpha = 1
                self.redCar.backgroundColor = UIColor.clear
            default:
                self.redCar.transform = .identity
                self.value = -1
            }
        }
    }
}

//MARK: - Private
private extension ViewControllerWithAnimator {
    @objc func sliderChanged(_ sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
}








