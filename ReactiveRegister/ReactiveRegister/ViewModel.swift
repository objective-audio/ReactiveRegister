//
//  ViewModel.swift
//  ReactiveRegister
//
//  Created by yasoshima on 2018/06/07.
//  Copyright © 2018年 Yuki Yasoshima. All rights reserved.
//

import Foundation
import Bond
import ReactiveKit

class ViewModel {
    let totalText = Observable<String>("")
    let taxText = Observable<String>("")
    let changeText = Observable<String>("")
    let paymentText = Observable<String>("")
    let countText = Observable<String>("")
    let countValue = Observable<Double>(0.0)
    var count: Observable<Int> { return self.checkout.count }
    var payment: Observable<NSDecimalNumber> { return self.checkout.payment }
    let canEnter = Observable<Bool>(false)
    
    private let register: Register = AppController.shared.register
    private var checkout: Checkout { return  self.register.checkout }
    private var numberPad: NumberPad { return self.register.numberPad }
    
    let disposeBag = DisposeBag()
    
    init() {
        self.count.bidirectionalBind(to: self.checkout.count).dispose(in: self.disposeBag)
        
        self.checkout.total.map { "合計 : \($0) 円" }.bind(to: self.totalText).dispose(in: self.disposeBag)
        self.checkout.count.map { "りんご x \($0) 個" }.bind(to: self.countText).dispose(in: self.disposeBag)
        self.checkout.count.map { Double($0) }.bind(to: self.countValue).dispose(in: self.disposeBag)
        self.checkout.change.map { "お釣り : \($0) 円" }.bind(to: self.changeText).dispose(in: self.disposeBag)
        self.checkout.payment.map { "支払い : \($0)" }.bind(to: self.paymentText).dispose(in: self.disposeBag)
        self.checkout.canEnter.bind(to: self.canEnter).dispose(in: self.disposeBag)
    }
    
    func input(command: NumberPad.Command) {
        self.numberPad.input(command: command)
    }
    
    func reset() {
        self.register.reset()
    }
}
