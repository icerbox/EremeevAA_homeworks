import UIKit

var animator: UIViewPropertyAnimator!

final class ViewController: UIViewController {
    //MARK: - Variables
    
    var animationsArray: [UIViewPropertyAnimator] = []
    
    var fishCounter: Int = 5
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Let's start!", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemBlue
        view.addSubview(button)
        return button
    }()
    
    lazy var Angelfish: UIImageView = {
        let Angelfish  = UIImageView(image: UIImage(named: "Angelfish"))
        Angelfish.contentMode = .scaleAspectFit
        Angelfish.translatesAutoresizingMaskIntoConstraints = false
        Angelfish.isUserInteractionEnabled = true
        tap(tappedView: Angelfish)
        view.addSubview(Angelfish)
        return Angelfish
    }()
    
    lazy var Bluefish: UIImageView = {
        let Bluefish  = UIImageView(image: UIImage(named: "Bluefish"))
        Bluefish.contentMode = .scaleAspectFit
        Bluefish.translatesAutoresizingMaskIntoConstraints = false
        Bluefish.isUserInteractionEnabled = true
        tap(tappedView: Bluefish)
        view.addSubview(Bluefish)
        return Bluefish
    }()
    
    lazy var Bluefish2: UIImageView = {
        let Bluefish2  = UIImageView(image: UIImage(named: "Bluefish2"))
        Bluefish2.contentMode = .scaleAspectFit
        Bluefish2.translatesAutoresizingMaskIntoConstraints = false
        Bluefish2.isUserInteractionEnabled = true
        tap(tappedView: Bluefish2)
        view.addSubview(Bluefish2)
        return Bluefish2
    }()
    
    lazy var Goldfish: UIImageView = {
        let Goldfish  = UIImageView(image: UIImage(named: "Goldfish"))
        Goldfish.contentMode = .scaleAspectFit
        Goldfish.translatesAutoresizingMaskIntoConstraints = false
        Goldfish.isUserInteractionEnabled = true
        tap(tappedView: Goldfish)
        view.addSubview(Goldfish)
        return Goldfish
    }()
    
    lazy var Kingfish: UIImageView = {
        let Kingfish  = UIImageView(image: UIImage(named: "Kingfish"))
        Kingfish.contentMode = .scaleAspectFit
        Kingfish.translatesAutoresizingMaskIntoConstraints = false
        Kingfish.isUserInteractionEnabled = true
        tap(tappedView: Kingfish)
        view.addSubview(Kingfish)
        return Kingfish
    }()
    
    // Объявляем метод для отслеживания тапа по UIImageView при помощи класса UITapGestureRecognizer. Если пользователь тапнул по картинке рыбки то запускаем метод с селектором imageTapped
    private func tap(tappedView: UIImageView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        tappedView.addGestureRecognizer(tap)
    }
    
}

//MARK: - UIViewController
extension ViewController {
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Настраиваем констрейнты
        setupConstraints()
        
    }
    //MARK: - viewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Добавляем кнопку при нажатии на которую запускается метод startAnimations()
        button.addAction(
            UIAction(handler: { [weak self] _ in
                guard let self = self else { return }
                self.startAnimations()
            }), for: .touchUpInside)
    }
    // Объявляем метод для настройки констрейнтов
    func setupConstraints() {
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        Angelfish.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -100).isActive = true
        Angelfish.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        Angelfish.widthAnchor.constraint(equalToConstant: 100).isActive = true
        Angelfish.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        Bluefish.rightAnchor.constraint(equalTo: view.rightAnchor, constant: +100).isActive = true
        Bluefish.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        Bluefish.widthAnchor.constraint(equalToConstant: 100).isActive = true
        Bluefish.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        Bluefish2.leftAnchor.constraint(equalTo: view.leftAnchor,constant: -100).isActive = true
        Bluefish2.topAnchor.constraint(equalTo: view.topAnchor, constant: 280).isActive = true
        Bluefish2.widthAnchor.constraint(equalToConstant: 100).isActive = true
        Bluefish2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        Kingfish.rightAnchor.constraint(equalTo: view.rightAnchor, constant: +100).isActive = true
        Kingfish.topAnchor.constraint(equalTo: view.topAnchor, constant: 400).isActive = true
        Kingfish.widthAnchor.constraint(equalToConstant: 100).isActive = true
        Kingfish.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        Goldfish.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -100).isActive = true
        Goldfish.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        Goldfish.widthAnchor.constraint(equalToConstant: 100).isActive = true
        Goldfish.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    // Объявляем метод который запускает анимацию рыбок. Для анимации используем класс UIViewPropertyAnimator, метод принимает необходимый UIImageView, duration - продолжительность анимации, translationX - направление в котором двигать рыбку.
    func animate(imageView: UIImageView, duration: Double, translationX: CGFloat) -> UIViewPropertyAnimator {
        // создаем экземпляр UIViewPropertyAnimator
        animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut)
        // Добавляем анимацию для движения рыбок по оси X при помощи CGAffineTransform
        animator.addAnimations {
            imageView.transform = CGAffineTransform(translationX: translationX, y: 0)
        }
        // По завершении цикла анимации
        animator.addCompletion {_ in
            print("Возвращаем анимацию на начальную позицию")
            imageView.transform = .identity
            
            self.startAnimations()
        }
        return animator
    }
    
    func startAnimations() {
        stopAnimations()
        self.animationsArray = []
        let angelFishAnimation = animate(imageView: Angelfish, duration: 4.5, translationX: 500)
        angelFishAnimation.startAnimation()
        animationsArray.append(angelFishAnimation)
        let blueFishAnimation = animate(imageView: Bluefish, duration: 3.4, translationX: -500)
        blueFishAnimation.startAnimation()
        animationsArray.append(blueFishAnimation)
        let blueFish2Animation = animate(imageView: Bluefish2, duration: 5.0, translationX: 500)
        blueFish2Animation.startAnimation()
        animationsArray.append(blueFish2Animation)
        let kingFishAnimation = animate(imageView: Kingfish, duration: 6.0, translationX: -500)
        kingFishAnimation.startAnimation()
        animationsArray.append(kingFishAnimation)
        let goldFishAnimation = animate(imageView: Goldfish, duration: 8.0, translationX: 500)
        goldFishAnimation.startAnimation()
        animationsArray.append(goldFishAnimation)
    }
    func stopAnimations() {
        for i in animationsArray {
            i.stopAnimation(true)
        }
    }
    func stopAnimationsIfAllTapped() {
        if fishCounter == 0 {
            stopAnimations()
            print("All animations stopped")
        }
    }
    @objc func imageTapped(_ recognizer: UIPanGestureRecognizer)
    {
        print("Image tapped")
        if recognizer.view == Angelfish {
            self.Angelfish.alpha = 0.0
            fishCounter -= 1
            stopAnimationsIfAllTapped()
        } else if recognizer.view == Bluefish {
            self.Bluefish.alpha = 0.0
            fishCounter -= 1
            stopAnimationsIfAllTapped()
        } else if recognizer.view == Bluefish2 {
            self.Bluefish2.alpha = 0.0
            fishCounter -= 1
            stopAnimationsIfAllTapped()
        } else if recognizer.view == Goldfish {
            self.Goldfish.alpha = 0.0
            fishCounter -= 1
            stopAnimationsIfAllTapped()
        } else {
            self.Kingfish.alpha = 0.0
            fishCounter -= 1
            stopAnimationsIfAllTapped()
        }
    }
}








