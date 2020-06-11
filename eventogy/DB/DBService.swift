//
//  DBService.swift
//  Eventogy
//
//  Created by zip520123 on 11/06/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import Foundation
import RxSwift
protocol DB {
  func save(contacts: [Contact]) -> Observable<()>
  func readContacts() -> Observable<[Contact]>
}

struct UserDefaultDB: DB {
  static let savedContactKey = "savedContactKey"
  
  func save(contacts: [Contact]) -> Observable<()> {
    return Observable.create { (observer) in
      if let encoded = try? JSONEncoder().encode(contacts) {
        UserDefaults.standard.set(encoded, forKey: UserDefaultDB.savedContactKey)
        observer.onNext(())
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
  
  func readContacts() -> Observable<[Contact]> {
    return Observable.create { (observer) in
      
      guard let data = UserDefaults.standard.object(forKey: UserDefaultDB.savedContactKey) as? Data,
        let savedPosts = try? JSONDecoder().decode([Contact].self, from: data) else {
          observer.onNext([])
          observer.onCompleted()
          return Disposables.create()
      }
      
      observer.onNext(savedPosts)
      observer.onCompleted()
      
      return Disposables.create()
    }
  }
}
