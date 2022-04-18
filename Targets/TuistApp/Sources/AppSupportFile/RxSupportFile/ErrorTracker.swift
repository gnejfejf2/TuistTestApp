
import RxSwift
import RxCocoa

open class ErrorTracker: SharedSequenceConvertibleType {
   public typealias SharingStrategy = DriverSharingStrategy
   private let _subject = PublishSubject<Error>()
   
   public init() {
       
   }

   open func trackError<O: ObservableConvertibleType>(from source: O) -> Observable<O.Element> {
       return source.asObservable().do(onError: onError)
   }

   open func asSharedSequence() -> SharedSequence<SharingStrategy, Error> {
       return _subject.asObservable().asDriverOnErrorNever()
   }

   open func asObservable() -> Observable<Error> {
       return _subject.asObservable()
   }

   private func onError(_ error: Error) {
       _subject.onNext(error)
   }
   
   deinit {
       _subject.onCompleted()
   }
}

extension ObservableConvertibleType {
    public func trackError(_ errorTracker: ErrorTracker) -> Observable<Element> {
        return errorTracker.trackError(from: self)
    }
}
