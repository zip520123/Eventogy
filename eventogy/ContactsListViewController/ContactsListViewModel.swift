import Foundation
import RxSwift
import RxCocoa


final class ContactsListViewModel {

  struct ContactsListViewModelInputs {
    let shouldGetContact: PublishRelay<()>
    let shouldShowContactDetail: PublishRelay<Contact>
  }

  struct ContactsListViewModelOutputs {
    let didGetContact: Driver<[Contact]>
    let showContactDetail: Driver<Contact>
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
    
    let shouldShowContactDetail = PublishRelay<Contact>()
    let showContactDetail = shouldShowContactDetail.asDriverOnErrorJustIgnored()

    inputs = ContactsListViewModelInputs(shouldGetContact: shouldGetContact, shouldShowContactDetail: shouldShowContactDetail)
    outputs = ContactsListViewModelOutputs(didGetContact: didGetContact, showContactDetail: showContactDetail)
  }

}
