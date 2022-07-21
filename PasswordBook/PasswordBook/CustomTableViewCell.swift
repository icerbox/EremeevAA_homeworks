import Foundation
import UIKit

var loginLabel: UILabel = {
  let label = UILabel()
  label.lineBreakMode = .byWordWrapping
  label.numberOfLines = 0
  label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
  return label
}()


extension UITableViewCell {
  
  func makeCustomText (model: Password?) {
    guard let _ = model else {
      return
    }
    let customText = model!.login + " " + model!.ip + " " + model!.fullname
    self.textLabel?.text = customText
  }
}
