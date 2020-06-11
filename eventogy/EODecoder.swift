//
//  EODecoder.swift
//  Eventogy
//
//  Created by zip520123 on 11/06/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import Foundation
class EODecoder: JSONDecoder {
  override init() {
    super.init()
    dateDecodingStrategy = .secondsSince1970
  }
}
