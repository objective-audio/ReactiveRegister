//
//  Checkout.swift
//  ReactiveRegister
//
//  Created by yasoshima on 2018/05/14.
//  Copyright © 2018年 Yuki Yasoshima. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

class Checkout {
    let menu = Menu()
    
    let count = Observable<Int>(1)
    let total = Observable<NSDecimalNumber>(.zero)
    let tax = Observable<NSDecimalNumber>(.zero)
    let payment = Observable<NSDecimalNumber>(.zero)
    let change = Observable<NSDecimalNumber>(.zero)
    let canEnter = Observable<Bool>(false)
    
    let disposeBag = DisposeBag()
    
    init() {
        self.menu.price.combineLatest(with: self.count.map { NSDecimalNumber(string: "\($0)") }).map { (price, count) in
            return price.multiplying(by: NSDecimalNumber(string: "\(count)"))
        }.bind(to: self.total).dispose(in: self.disposeBag)
        
        self.menu.taxRate.combineLatest(with: self.total).map { (taxRate: Int, total: NSDecimalNumber) -> NSDecimalNumber in
            let handler = NSDecimalNumberHandler(roundingMode: .plain,
                                                 scale: 0,
                                                 raiseOnExactness: false,
                                                 raiseOnOverflow: false,
                                                 raiseOnUnderflow: false,
                                                 raiseOnDivideByZero: false)
            return total.multiplying(by: NSDecimalNumber(string: "\(taxRate)")).dividing(by: NSDecimalNumber(string: "\(100 + taxRate)"), withBehavior: handler)
        }.bind(to: self.tax).dispose(in: self.disposeBag)
        
        self.payment.combineLatest(with: self.total).map { (payment, total) -> NSDecimalNumber in
            let change = payment.subtracting(total)
            if change.compare(NSDecimalNumber.zero) == .orderedDescending {
                return change
            } else {
                return .zero
            }
        }.bind(to: self.change).dispose(in: self.disposeBag)
        
        self.payment.combineLatest(with: self.total).map { (payment, total) -> Bool in
            return payment.subtracting(total).compare(NSDecimalNumber.zero) != .orderedAscending
        }.bind(to: self.canEnter).dispose(in: self.disposeBag)
    }
}
