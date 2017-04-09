//: Playground - noun: a place where people can play

import UIKit
import RxSwift

let one = 1
let two = 2
let three = 3

let observeable = Observable.of(one, two, three)

observeable.subscribe(
    onNext: { element in
        print(element)
    },
    onCompleted: {
        print("Completed")
    }
)