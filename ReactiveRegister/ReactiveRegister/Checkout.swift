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
    let total: Observable<NSDecimalNumber>
    
    private let disposeBag = DisposeBag()
    
    init() {
        let countObservable = self.countRelay.map { NSDecimalNumber(string: "\($0)") }
        
        self.total = Observable.combineLatest(self.menu.price, countObservable).map { (price, count) in
            return price.multiplying(by: NSDecimalNumber(string: "\(count)"))
            }
    }
}
