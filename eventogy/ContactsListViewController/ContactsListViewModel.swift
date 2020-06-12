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

  init(service: ServiceType, db: DB = UserDefaultDB()) {
    let currentPage = BehaviorRelay<Int>(value: 1)
    let shouldSaveContacts = PublishRelay<[Contact]>()
    let shouldGetContact = PublishRelay<()>()

    shouldSaveContacts.flatMapFirst({ (contacts) in
      db.save(contacts: contacts) })
    .subscribe(onNext: { (_) in
      print("did save contacts") })
    .disposed(by: disposeBag)

    let didGetContact = shouldGetContact
      .withLatestFrom(currentPage)
      .flatMapFirst { page in
        service.requestContact(page: page)
      }
      .do(onNext: { (contacts) in
        shouldSaveContacts.accept(contacts)
        currentPage.nextPage()
      })
      .catchError({ (_) in
        db.readContacts()
      })
      .asDriverOnErrorJustIgnored()

    let shouldShowContactDetail = PublishRelay<Contact>()
    let showContactDetail = shouldShowContactDetail.asDriverOnErrorJustIgnored()

    inputs = ContactsListViewModelInputs(shouldGetContact: shouldGetContact, shouldShowContactDetail: shouldShowContactDetail)
    outputs = ContactsListViewModelOutputs(didGetContact: didGetContact, showContactDetail: showContactDetail)
  }

}
