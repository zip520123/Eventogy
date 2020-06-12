//
//  ContactDetailViewController.swift
//  Eventogy
//
//  Created by zip520123 on 11/06/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

enum ContactDetailCellType {
  case profileImage
  case firstName
  case lastName
  case address
  case phoneNumber
  case email
  case marketing
  case dateCreated
  case dateLastUpdate
}

extension Array where Element == ContactDetailCellType {
  static var basic: [ContactDetailCellType] {
    return [.profileImage, .firstName, .lastName, .address, .phoneNumber, .email, .marketing, .dateCreated, .dateLastUpdate]
  }
}

final class ContactDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  private let tableView = UITableView()
  private let cellType: [ContactDetailCellType] = .basic
  private let contact: Contact

  init(contact: Contact) {
    self.contact = contact
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  private func setupUI() {
    title = (contact.firstName ?? "") + " " + (contact.lastName ?? "")
    view.backgroundColor = .white

    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    tableView.tableFooterView = UIView()

    tableView.delegate = self
    tableView.dataSource = self
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellType.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    var cell = UITableViewCell(style: .value1, reuseIdentifier: nil)

    switch cellType[indexPath.row] {
    case .profileImage:
      if let url = URL(string: contact.avatarURL) {
        cell.imageView?.kf.setImage(with: url)
      }

    case .firstName:
      cell.textLabel?.text = "First Name:"
      cell.detailTextLabel?.text = contact.firstName ?? ""
    case .lastName:
      cell.textLabel?.text = "Last Name:"
      cell.detailTextLabel?.text = contact.lastName ?? ""
    case .address:
      cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
      cell.textLabel?.text = "Address:"
      cell.detailTextLabel?.text = contact.address ?? ""
      cell.detailTextLabel?.numberOfLines = 0

    case .phoneNumber:
      cell.textLabel?.text = "Phone Number:"
      cell.detailTextLabel?.text = contact.phoneNumber ?? ""
    case .email:
      cell.textLabel?.text = "Email address:"
      cell.detailTextLabel?.text = contact.email ?? ""

    case .marketing:
      cell.textLabel?.text = "Marketing:"
      cell.detailTextLabel?.text = contact.marketing?.description ?? ""

    case .dateCreated:
      cell.textLabel?.text = "Date created:"
      let dateFormater = DateFormatter()
      dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
      if let date = contact.createdAt {
        let dateString = dateFormater.string(from: date)
        cell.detailTextLabel?.text = dateString
      } else {
        cell.detailTextLabel?.text = "unknow"
      }
    case .dateLastUpdate:
      cell.textLabel?.text = "Date last updated:"
      let dateFormater = DateFormatter()
      dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
      if let date = contact.updatedAt {
        let dateString = dateFormater.string(from: date)
        cell.detailTextLabel?.text = dateString
      } else {
        cell.detailTextLabel?.text = "unknow"
      }
    }

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(contact)

    tableView.deselectRow(at: indexPath, animated: true)
  }
}
