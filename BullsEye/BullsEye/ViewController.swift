import UIKit

class ViewController: UIViewController {
    
  var currentValue: Int = 0
  var targetValue = 0
  var score = 0
  var round = 0

  @IBOutlet var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!

    
  override func viewDidLoad() {
    super.viewDidLoad()
    startNewRound()
    
    let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
    slider.setThumbImage(thumbImageNormal, for: .normal)
    
    let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
    slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
    
    let insets = UIEdgeInsets(
      top: 0,
      left: 14,
      bottom: 0,
      right: 14)
    
    let trackLeftImage = UIImage(named: "SliderTrackLeft")!
    let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
    slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
    
    let trackRightImage = UIImage(named: "SliderTrackRight")!
    let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
    slider.setMaximumTrackImage(trackRightResizable, for: .normal)
  }

  @IBAction func startNewGame() {
    score = 0
    round = 0
    startNewRound()
  }
  
  @IBAction func showAlert() {
    let difference = abs(targetValue - currentValue)
    var points = 100 - difference
    
    let title: String
    
    if difference == 0 {
      title = "Отлично! Добавляем дополнительные 100 очков"
      points += 100
    } else if difference < 5 {
      title = "Ты почти угадал!"
      if difference == 1 {
        points += 50
      }
    } else if difference < 10 {
      title = "Неплохо но не угадал!"
    } else {
      title = "Даже рядом нет..."
    }
    
    score += points
    
    let message = "Ты набрал \(points) очков" + "\nЗначение слайдера: \(currentValue)" + "\nЦелевое значение: \(targetValue)" + "\nРазница значений: \(difference) "
        + "\nОбщее количество очков: \(score)"
    
    let alert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert)
      
    let action = UIAlertAction(
      title: "OK",
      style: .default) { _ in
        self.startNewRound()
      }
      
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
  }
  
  func startNewRound() {
    print("Начинаем новый раунд")
    round += 1
    targetValue = Int.random(in: 1...100)
    currentValue = 50
    slider.value = Float(currentValue)
    updateLabels()
  }
    
  func updateLabels() {
    targetLabel.text = String(targetValue)
    scoreLabel.text = String(score)
    roundLabel.text = String(round)
  }
    
  @IBAction func sliderMoved(_ slider: UISlider) {
    print("Текущее значение слайдера: \(slider.value)")
    currentValue = lroundf(slider.value)
  }
}
