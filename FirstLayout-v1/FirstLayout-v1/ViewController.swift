import UIKit

final class ViewController: UIViewController {
  
  @IBOutlet private var tileView: TileView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  // После загрузки сабвью:
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    // Устанавливаем радиус углов, чтобы сделать округленные углы
    let radius = tileView.bounds.width / 20
    tileView.layer.cornerRadius = radius
  }
}

