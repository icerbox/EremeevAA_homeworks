import UIKit

class Checklist: NSObject, Codable {
  // Объявляем переменную для имен чеклистов
  var name = ""
  
  // Объявляем переменную для имен иконок
  var iconName = "No Icon"
  
  // Создаем пустой массив который будет содержать объекты ChecklistItem, чтобы каждый список мог содержать свои отдельные задачи.
  var items = [ChecklistItem]()
  
  init(name: String, iconName: String = "No Icon") {
    self.name = name
    self.iconName = iconName
    super.init()
  }

  // Этот метод опрашивает объект Checklist сколько объектов ChecklistItem не отмечены галочкой (не завершены). Возвращает количество не завершенных заданий в значении Int.
  func countUncheckedItems() -> Int {
    var count = 0
    // Если объект item имеет свойство "Не завершено" (!item.checked), инкрементируем локальную переменную count на 1.
    for item in items where !item.checked {
      count += 1
    }
    return count 
  }
  
  // Метод для сортировки задач по названию
  func sortChecklistItems() {
    items.sort { item1, item2 in
      return item1.dueDate.compare(item2.dueDate) == .orderedAscending
    }
  }
}
