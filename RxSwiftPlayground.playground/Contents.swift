//: Playground - noun: a place where people can play

import UIKit
import RxSwift

enum Errors: Error {
    case anError
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, event.element ?? event.error ?? event)
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

//# Simple BehaviorSubject
let behaviorSubject = BehaviorSubject(value: "Initial value")

// receiveives the initial value, because behaviorSubjects emit the latest value onSubscription
behaviorSubject.subscribe {
    print(label: "1)", event: $0)
}.addDisposableTo(disposeBag)
// 1) and 2) will receive tis value, but 2) will receive only this message
behaviorSubject.on(.next("next value"))
behaviorSubject.subscribe {
    print(label: "2)", event: $0)
}.addDisposableTo(disposeBag)

//# Simple ReplaySubject
let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
replaySubject.on(.next("Initial replay subject value"))
replaySubject.on(.next("second value"))
replaySubject.subscribe {
    print(label: "Replay 1)", event: $0)
}.addDisposableTo(disposeBag)
replaySubject.on(.next("Third value"))
replaySubject.subscribe { // does not receive the first, because the bufferSize is 1
    print(label: "Replay 2)", event: $0)
}.addDisposableTo(disposeBag)

//# Variable example
let aVariable = Variable("Initial value")
aVariable.value = "another value"
aVariable.asObservable()
    .subscribe {
        print(label: "Var a)", event: $0)
    }.addDisposableTo(disposeBag)
aVariable.value = "hey ho"
// Variables can emmit only values - no erros or completed events

// Filter
Observable.of(1,2,3,4,5,6)
    .filter { integer in
        integer % 2 == 0
    }
    .subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)