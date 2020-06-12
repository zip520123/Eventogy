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
  var contactsCoordinator: ContactsListCoordinator?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = contactsListCoordinator()
    window?.makeKeyAndVisible()
    return true
  }
  func contactsListCoordinator() -> UINavigationController {
    let navgationController = UINavigationController()
    contactsCoordinator = ContactsListCoordinator(navigationController: navgationController, service: Service())
    contactsCoordinator?.start()
    return navgationController
  }

}
