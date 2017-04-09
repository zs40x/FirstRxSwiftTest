//: Playground - noun: a place where people can play

import UIKit
import RxSwift

let disposeBag = DisposeBag()
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