//
//  Register.swift
//  ReactiveRegister
//
//  Created by yasoshima on 2018/05/14.
//  Copyright © 2018年 Yuki Yasoshima. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class Register {
    let numberPad = NumberPad()
    let checkout = Checkout()
    
    let resetRelay = PublishRelay<Void>()
    
    let disposeBag = DisposeBag()
    
    init() {
        self.numberPad.amount.asDriver().drive(self.checkout.payment).disposed(by: self.disposeBag)
        
        self.resetRelay.asDriver(onErrorDriveWith: Driver.empty()).map { 1 }.drive(self.checkout.count).disposed(by: self.disposeBag)
        self.resetRelay.asSignal().map { NumberPad.Command.clear }.emit(to: self.numberPad.input ).disposed(by: self.disposeBag)
    }
    
    func reset() {
        self.checkout.count.accept(1)
        self.numberPad.input.accept(.clear)
    }
}
