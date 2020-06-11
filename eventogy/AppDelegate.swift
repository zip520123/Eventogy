//
//  AppDelegate.swift
//  eventogy
//
//  Created by zip520123 on 11/06/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    
    let vc = UIViewController()
    vc.view.backgroundColor = .white
    window?.rootViewController = vc
    window?.makeKeyAndVisible()
    return true
  }
  

}

