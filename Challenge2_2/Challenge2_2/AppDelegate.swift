//
//  AppDelegate.swift
//  Challenge2_2
//
//  Created by Андрей Антонен on 14.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
    window?.rootViewController = RootViewController()
    window?.makeKeyAndVisible()
    return true
  }
}

