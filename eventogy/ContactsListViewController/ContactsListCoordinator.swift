//
//  ContactsListCoordinator.swift
//  Eventogy
//
//  Created by zip520123 on 11/06/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import UIKit

protocol ContactsListCoordinatorProtocol: AnyObject {
  init(navigationController: UINavigationController, service: ServiceType)
  func start()
}

final class ContactsListCoordinator: ContactsListCoordinatorProtocol {
  
  let viewModel: ContactsListViewModel
  private let navigation : UINavigationController
  
  init(navigationController: UINavigationController, service: ServiceType) {
    self.viewModel = ContactsListViewModel(service: service)
    self.navigation = navigationController
    rxbinding()
  }
  
  func rxbinding() {
    
  }
  
  func start() {
    let contactsListViewController = ContactsListViewController(viewModel: viewModel)
    navigation.setViewControllers([contactsListViewController], animated: false)
    
  }
}
