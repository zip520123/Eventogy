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
    
    let service = try! mockService(with: "contacts.json")
    contactsCoordinator = ContactsListCoordinator(navigationController: navgationController, service: service)
    contactsCoordinator?.start()
    return navgationController
  }
  
  func readString(from file: String) throws -> String {
    let bundle = Bundle(for: type(of: self))
    let path = bundle.url(forResource: file, withExtension: nil)!
    let data = try Data(contentsOf: path)
    return String(data: data, encoding: .utf8)!
  }
  
  func mockService(with file: String) throws -> MockService {
    return MockService(testString: try readString(from: file))
  }
}

