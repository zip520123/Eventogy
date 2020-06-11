//
//  Service.swift
//  Eventogy
//
//  Created by zip520123 on 11/06/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

enum NetworkError: Error {
  case dataIsNil
}

struct Service: ServiceType {
  
  func requestContact(page: Int) -> Observable<[Contact]> {
    return Observable<[Contact]>.create { (observer) -> Disposable in
      
      let path = "https://demomedia.co.uk/files/contacts.json"
      let request = AF.request(path).responseDecodable(of: [Contact].self, decoder: EODecoder()) { (response) in
        do {
          let contacts = try response.result.get()
          observer.onNext(contacts)
          observer.onCompleted()
        } catch {
          observer.onError(error)
        }
      }
      return Disposables.create {
        request.cancel()
      }
    }
  }
}

