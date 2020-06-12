//
//  eventogyTests.swift
//  eventogyTests
//
//  Created by zip520123 on 11/06/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import XCTest
import RxSwift
@testable import Eventogy

class EventogyTests: XCTestCase {
  let disposeBag = DisposeBag()

  override func setUp() {
    super.setUp()
    //remove all keys in userDefault
    if let appDomain = Bundle.main.bundleIdentifier {
      UserDefaults.standard.removePersistentDomain(forName: appDomain)
    }
  }

  func testDecodeContact() throws {
    let data = try readString(from: "contacts.json").data(using: .utf8)!

    let model = try EODecoder().decode([Contact].self, from: data)

    XCTAssert(model.count == 6)
    XCTAssert(model[0].id == 100)
    XCTAssert(model[0].title == "Mr")
    XCTAssert(model[0].firstName == "Steve")
    XCTAssert(model[0].lastName == "Williams")
    XCTAssert(model[0].address == "31 Old Street,\nWoolwich,\nLondon,\nSE15 7KE")
    XCTAssert(model[0].phoneNumber == "07888888888")
    XCTAssert(model[0].email == "steve@email.com")
    XCTAssert(model[0].marketing == true)
    XCTAssert(model[0].createdAt == Date(timeIntervalSince1970: 1587554436))
    XCTAssert(model[0].updatedAt == Date(timeIntervalSince1970: 1587554536))
  }

  func testContactViewModel_FetchFunction() throws {
    let service = try mockService(with: "contacts.json")
    let viewModel = ContactsListViewModel(service: service)
    let expection = XCTestExpectation()

    viewModel.outputs.didGetContact.drive(onNext: { (_) in
      expection.fulfill()
    }).disposed(by: disposeBag)

    viewModel.inputs.shouldGetContact.acceptAction()

    wait(for: [expection], timeout: 5)

  }

  func testRealApiRequest() {
    let service = Service()
    let expectation = XCTestExpectation()

    service.requestContact(page: 1).subscribe(onNext: { (_) in
      expectation.fulfill()
    }).disposed(by: disposeBag)

    wait(for: [expectation], timeout: 5)
  }

  func testDBReadWrite() throws {
    let db = UserDefaultDB()
    let data = try readString(from: "contacts.json").data(using: .utf8)!
    let fakeContacts = try EODecoder().decode([Contact].self, from: data)
    let expectation = XCTestExpectation()

    db.readContacts().flatMap { (contacts) -> Observable<()> in
        XCTAssert(contacts.count == 0)
        return db.save(contacts: fakeContacts)
      }
      .flatMap({
        return db.readContacts()
      })
      .subscribe(onNext: { (contacts) in
        XCTAssert(contacts.count == 6)
        expectation.fulfill()
      })
      .disposed(by: disposeBag)

    wait(for: [expectation], timeout: 5)
  }

}

extension XCTestCase {
  func mockService(with file: String) throws -> MockService {
    return MockService(testString: try readString(from: file))
  }
  func readString(from file: String) throws -> String {
    //Json fails reading multiline string. Instead read json from file https://bugs.swift.org/browse/SR-6457
    let bundle = Bundle(for: type(of: self))
    let path = bundle.url(forResource: file, withExtension: nil)!
    let data = try Data(contentsOf: path)
    return String(data: data, encoding: .utf8)!
  }
}
