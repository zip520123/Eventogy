//
//  ContactsListViewController.swift
//  Eventogy
//
//  Created by zip520123 on 11/06/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import Kingfisher

final class ContactsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  private var contacts = [Contact]()
  private let disposeBag = DisposeBag()
  private let tableView = UITableView()
  private let viewModel : ContactsListViewModel
  
  init(viewModel: ContactsListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    rxBinding()
  }

  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    requestData()
  }
  
  private func rxBinding() {
    viewModel.outputs.didGetContact.drive(onNext: {[weak self] (contacts) in
      self?.contacts = contacts
      self?.tableView.reloadData()
    }).disposed(by: disposeBag)
  }
  
  private func setupUI() {
    title = "Contacts"
    view.backgroundColor = .white
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    tableView.backgroundColor = .white
    tableView.tableFooterView = UIView()
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  private func requestData() {
    viewModel.inputs.shouldGetContact.acceptAction()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contacts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    let contact = contacts[indexPath.row]
    
    if let url = URL(string: contact.avatarURL) {
      cell.imageView?.kf.setImage(with: url, completionHandler: { (result) in
        switch result {
        case .success(_):
          cell.setNeedsLayout()
        case .failure(let error):
          print(error)
        }
      })
    }
    if let firstName = contact.firstName,
       let lastName = contact.lastName {
      cell.textLabel?.text = firstName + " " + lastName
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    defer {
      tableView.deselectRow(at: indexPath, animated: true)
    }
    let contact = contacts[indexPath.row]
    viewModel.inputs.shouldShowContactDetail.accept(contact)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
