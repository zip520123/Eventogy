import Foundation
import RxSwift
import RxCocoa


final class ContactsListViewModel {

  struct ContactsListViewModelInputs {
    let shouldGetContact: PublishRelay<()>
  }

  struct ContactsListViewModelOutputs {
    let didGetContact: Driver<[Contact]>
  }

  var inputs: ContactsListViewModelInputs
  var outputs: ContactsListViewModelOutputs

  let disposeBag = DisposeBag()

  init(service: ServiceType) {
    let currentPage = BehaviorRelay<Int>(value: 1)
    
    let shouldGetContact = PublishRelay<()>()
    
    let didGetContact = shouldGetContact
      .withLatestFrom(currentPage)
      .flatMapFirst { page in
        service.requestContact(page: page)
      }
      .do(onNext: { (contacts) in
        currentPage.nextPage()
      })
      .asDriverOnErrorJustIgnored()

    inputs = ContactsListViewModelInputs(shouldGetContact: shouldGetContact)
    outputs = ContactsListViewModelOutputs(didGetContact: didGetContact)
  }

}
