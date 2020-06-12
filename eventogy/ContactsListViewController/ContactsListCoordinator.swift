//
//  ContactsListCoordinator.swift
//  Eventogy
//
//  Created by zip520123 on 11/06/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import UIKit
import RxSwift

protocol ContactsListCoordinatorProtocol: AnyObject {
  init(navigationController: UINavigationController, service: ServiceType)
  func start()
}

final class ContactsListCoordinator: ContactsListCoordinatorProtocol {

  private let viewModel: ContactsListViewModel
  private let navigation: UINavigationController
  private let disposeBag = DisposeBag()

  init(navigationController: UINavigationController, service: ServiceType) {
    self.viewModel = ContactsListViewModel(service: service)
    self.navigation = navigationController
    rxbinding()
  }

  func rxbinding() {
    viewModel.outputs.showContactDetail.drive(onNext: {[weak self] (contact) in
      let contactDetailViewController = ContactDetailViewController(contact: contact)
      self?.navigation.pushViewController(contactDetailViewController, animated: true)
    }).disposed(by: disposeBag)
  }

  func start() {
    let contactsListViewController = ContactsListViewController(viewModel: viewModel)
    navigation.setViewControllers([contactsListViewController], animated: false)

  }
}
