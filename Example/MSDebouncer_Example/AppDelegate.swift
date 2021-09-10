//
//  AppDelegate.swift
//  MSDebouncer_Example
//
//  Created by Maxim Skryabin on 10.09.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setupWindow()
    
    return true
  }
  
  private func setupWindow() {
    let window = UIWindow()
    window.rootViewController = ViewController()
    window.makeKeyAndVisible()
    self.window = window
  }
}
