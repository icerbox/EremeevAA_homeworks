import UIKit

// Xcode поддерживает отображение кастомных вью в интерфейс билдере при добавлении ключевого слова @IBDesignable
@IBDesignable
final class TileView: UIView {
  // Объявлявем вью красного цвета
  private let redView: UIView = {
    let view = UIView()
    view.backgroundColor = .red
    return view
  }()
  
  // Объявлявем вью синего цвета
  private let blueView: UIView = {
    let view = UIView()
    view.backgroundColor = .blue
    return view
  }()
  
  // Объявляем переменную для паддинга
  // Делаем переменную для паддинга редактируемым в интерфейс билдере присвоив ключевое слово @IBInspectable
  @IBInspectable var padding: CGFloat = 25.0 {
    didSet {
      setNeedsLayout()
    }
  }
  // Этот инициализатор вызывается когда мы создаем вью в коде
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  // Этот инициализатор вызывается при загрузке вью из nib файла или сториборда
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  // Добавляем наши вью
  private func setupView() {
    addSubview(blueView)
    addSubview(redView)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    // Размер container view
    let containerWidth = bounds.width
    let containterHeight = bounds.height
    // Вычисляем ширину и высоту каждого элемента
    // Включая padding
    let numberOfItems: CGFloat = 2
    
    let itemWidth = (containerWidth - (numberOfItems + 1) * padding) / numberOfItems
    
    let itemHeight = containterHeight - 2 * padding
    
    // Устанавливаем фреймы двух сабвью
    blueView.frame = CGRect(x: padding, y: padding, width: itemWidth, height: itemHeight)
    redView.frame = CGRect(x: 2 * padding + itemWidth, y: padding, width: itemWidth, height: itemHeight)
  }

}
