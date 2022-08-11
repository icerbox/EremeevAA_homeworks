import Foundation
import UserNotifications

class ChecklistItem: NSObject, Codable {
  // Текст задачи
  var text = ""
  // Выполнено/не выполнено
  var checked = false
  // Дата выполнения напоминания
  var dueDate = Date()
  // Идентификатор напоминания
  var itemID = -1
  
  var shouldRemind = false
  
  
  init(text: String, checked: Bool) {
    self.text = text
    self.checked = checked
    super.init()
    // Когда приложение создает новый объект ChecklistItem просим DataModel выдать новый itemID и заменяем значение по умолчнию -1 на уникальный.
    itemID = DataModel.nextChecklistItemID()
  }
  // Специальный метод deinit будет вызван как при удалении задачи так и при удалении списка задач, так как все ChecklistItem'ы будут так же удалены, т.к. массив в котором они находятся будет освобожден
  deinit {
    removeNotification()
  }
  // Метод для планирования уведомления
  func scheduleNotification() {
    removeNotification()
    if shouldRemind && dueDate > Date() {
      // 1. Добавляем текст задачи в сообщения уведомления
      let content = UNMutableNotificationContent()
      content.title = "Reminder:"
      content.body = text
      content.sound = UNNotificationSound.default
      
      //2. Извлекаем год, месяц, день, час и минуту из указанной пользователем даты напоминания dueDate. Мы не учитываем секунды.
      let calendar = Calendar(identifier: .gregorian)
      let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
      
      //3. Для проверки локальных уведомлений мы используем UNTimeIntervalNotificationTrigger, который планирует появляющиеся через некоторое время уведомления. Здесь мы используем UNCalendarNotificationTrigger, который показывает уведомления в определенное время.
      let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
      
      //4. Создаем объект UNNotificationRequest. Здесь важно, то что мы конвертируем числовой ID в строку, и используем его для определения уведомления. Так мы сможем найти это уведомление позднее, если появится необходимость.
      let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
      
      //5. Добавляем новое уведомление в UNUserNotificationCenter
      let center = UNUserNotificationCenter.current()
      center.add(request)
    }
  }
  // Метод для удаления локального уведомления для текущей задачи если он существует.
  func removeNotification() {
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
  }
  
}
