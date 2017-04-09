//: Playground - noun: a place where people can play

import UIKit
import RxSwift

enum Errors: Error {
    case anError
}

let disposeBag = DisposeBag()

//# Simple observable example
let observeable = Observable<Int>.range(start: 1, count: 10)

observeable.subscribe(
    onNext: { element in
        print(element)
        
    },
    onError: { error in
        print("Error: \(error)")
    },
    onCompleted: {
        print("Completed")
    },
    onDisposed: {
        print("Disposed")
    }
).addDisposableTo(disposeBag)


//# Simple subject example
let subject = PublishSubject<String>()

subject.subscribe(
    onNext: { string in
        print(string)
    },
    onError: { error in
        print("Error: \(error)")
    },
    onDisposed: {
        print("String subject disposed")
    }
).addDisposableTo(disposeBag)

subject.on(.next("Hello world from a string subject"))
subject.on(.next("sdf"))
subject.on(.error(Errors.anError))