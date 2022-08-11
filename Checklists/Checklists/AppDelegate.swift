import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  
  // Метод делегата приложения .didFinishLaunchingOptions запускается при запуске приложения. Это входная точка приложения, первоем место в коде где мы можем делать что-то после запуска приложения
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Авторизация для уведомлений. Мы спрашиваем у iOs разрешения на отправку уведомлений со звуком с типом "alert"
    let center = UNUserNotificationCenter.current()
    center.delegate = self
//    center.requestAuthorization(options: [.alert, .sound]) {
//      granted, error in
//      if granted {
//        print("We have permission")
//        center.delegate = self
//      } else {
//        print("Permission denied")
//      }
//    }
    // UNMutableNotificationContent описывает что локальное уведомление будет выдавать. Здесь, мы устанавливаем что в уведомлении будет появляться сообщение типа alert
    let content = UNMutableNotificationContent()
    content.title = "Hello"
    content.body = "I am a local notification"
    content.sound = UNNotificationSound.default
    // Задаем время запуска уведомления. Оно появится через 10 секунд после запуска приложения.
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
    
    let request = UNNotificationRequest(identifier: "MyNotification", content: content, trigger: trigger)
    center.add(request)
    
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  // MARK: - Делегат уведомления пользователя
  
  // Этот метод будет вызываться когда локальное уведомление размещено и приложение все еще активно
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    print("Received local notification \(notification)")
  }

}

