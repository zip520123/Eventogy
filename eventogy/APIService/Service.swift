//
//  Service.swift
//  Eventogy
//
//  Created by zip520123 on 11/06/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import Foundation
import RxSwift

struct Service: ServiceType {
  
  func requestContact(page: Int) -> Observable<[Contact]> {
    return Observable.just([])
  }
  
}
