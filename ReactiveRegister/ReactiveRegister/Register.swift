//
//  Register.swift
//  ReactiveRegister
//
//  Created by yasoshima on 2018/05/14.
//  Copyright © 2018年 Yuki Yasoshima. All rights reserved.
//

import Foundation
import ReactiveKit

class Register {
    let numberPad = NumberPad()
    let checkout = Checkout()
    
    let disposeBag = DisposeBag()
    
    init() {
        self.numberPad.amount.bind(to: self.checkout.payment).dispose(in: self.disposeBag)
    }
    
    func reset() {
        self.checkout.count.value = 1
        self.numberPad.input(command: .clear)
    }
}
