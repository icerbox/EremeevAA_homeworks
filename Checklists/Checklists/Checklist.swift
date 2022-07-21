import UIKit

class Checklist: NSObject, Codable {
  var name = ""
  // Создаем пустой массив который будет содержать объекты ChecklistItem, чтобы каждый список мог содержать свои отдельные задачи.
  var items = [ChecklistItem]()
  
  init(name: String) {
    self.name = name
    super.init()
  }
}
