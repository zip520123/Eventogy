//
//  MockService.swift
//  Eventogy
//
//  Created by zip520123 on 11/06/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import Foundation
import RxSwift
struct MockService: ServiceType {
  var testString : String = ""
  func requestContact(page: Int) -> Observable<[Contact]> {
    let data = testString.data(using: .utf8)!
    let model = try! EODecoder().decode([Contact].self, from: data)
    return Observable.just(model)
  }
  
  
}
