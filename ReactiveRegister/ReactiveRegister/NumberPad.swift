//
//  Calculator.swift
//  ReactiveRegister
//
//  Created by yasoshima on 2018/05/14.
//  Copyright © 2018年 Yuki Yasoshima. All rights reserved.
//

import Foundation
import RxSwift

class NumberPad {
    var amount = Variable<NSDecimalNumber>(.zero)
    
    var amountHandler:((NSDecimalNumber) -> Void)?
    
    private var input: String = "" {
        didSet {
            if self.input != oldValue {
                self.updateAmount()
            }
        }
    }
    
    func input(number: Int) {
        self.input = self.input + "\(number)"
    }
    
    func clear() {
        self.input = ""
    }
    
    private func updateAmount() {
        let value = NSDecimalNumber(string: self.input)
        if value == .notANumber {
            self.amount.value = .zero
        } else {
            self.amount.value = value
        }
    }
}
