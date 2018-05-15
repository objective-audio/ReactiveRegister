//
//  Checkout.swift
//  ReactiveRegister
//
//  Created by yasoshima on 2018/05/14.
//  Copyright © 2018年 Yuki Yasoshima. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class Checkout {
    let menu = Menu()
    
    let count = BehaviorRelay<Int>(value: 1)
    let total: Observable<NSDecimalNumber>
    let tax: Observable<NSDecimalNumber>
    let payment = BehaviorRelay<NSDecimalNumber>(value: .zero)
    let change: Observable<NSDecimalNumber>
    let canEnter: Observable<Bool>
    
    init() {
        let countObservable = self.count.asObservable().map { NSDecimalNumber(string: "\($0)") }
        
        self.total = Observable.combineLatest(self.menu.price, countObservable).map { (price, count) in
            return price.multiplying(by: NSDecimalNumber(string: "\(count)"))
            }
        
        self.tax = Observable.combineLatest(self.menu.taxRate, self.total).map { (taxRate, total) in
            let handler = NSDecimalNumberHandler(roundingMode: .plain,
                                                 scale: 0,
                                                 raiseOnExactness: false,
                                                 raiseOnOverflow: false,
                                                 raiseOnUnderflow: false,
                                                 raiseOnDivideByZero: false)
            return total.multiplying(by: NSDecimalNumber(string: "\(taxRate)")).dividing(by: NSDecimalNumber(string: "\(100 + taxRate)"), withBehavior: handler)
        }
        
        self.change = Observable.combineLatest(self.payment, self.total).map { (payment, total) in
            let change = payment.subtracting(total)
            if change.compare(NSDecimalNumber.zero) == .orderedDescending {
                return change
            } else {
                return .zero
            }
        }
        
        self.canEnter = Observable.combineLatest(self.payment, self.total).map { (payment, total) in
            return payment.subtracting(total).compare(NSDecimalNumber.zero) != .orderedAscending
        }
    }
}
