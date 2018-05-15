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
    
    private let countRelay = BehaviorRelay<Int>(value: 1)
    var count: Observable<Int> { return self.countRelay.asObservable() }
    
    var total: NSDecimalNumber {
        return self.menu.price.multiplying(by: NSDecimalNumber(string: "\(self.countRelay.value)"))
    }
    
    var tax: NSDecimalNumber {
        return .zero
    }
}
