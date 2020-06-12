//
//  Contact.swift
//  Eventogy
//
//  Created by zip520123 on 11/06/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import Foundation

struct Contact: Codable {
  let id: Int
  let index: Int?
  let title: String?
  let firstName: String?
  let lastName: String?
  let address: String?
  let phoneNumber: String?
  let email: String?
  let marketing: Bool?
  let createdAt: Date?
  let updatedAt: Date?
  var avatarURL: String {
      return "https://api.adorable.io/avatars/285/\(firstName ?? "")\(lastName ?? "")\(id)@adorable.io.png"
  }

  private enum CodingKeys: String, CodingKey {
    case id
    case index
    case title
    case firstName
    case lastName
    case address
    case phoneNumber
    case email
    case marketing
    case createdAt
    case updatedAt
  }

}
