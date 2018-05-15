//
//  Register.swift
//  ReactiveRegister
//
//  Created by yasoshima on 2018/05/14.
//  Copyright © 2018年 Yuki Yasoshima. All rights reserved.
//

import Foundation
import RxSwift

class Register {
    let numberPad = NumberPad()
    let checkout = Checkout()
    
    let disposeBag = DisposeBag()
    
    init() {
        self.numberPad.amount.asDriver().drive(self.checkout.payment).disposed(by: self.disposeBag)
    }
    
    func reset() {
        self.checkout.count.accept(1)
        self.numberPad.input.accept(.clear)
    }
}
