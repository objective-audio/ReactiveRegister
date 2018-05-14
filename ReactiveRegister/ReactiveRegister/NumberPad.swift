//
//  Calculator.swift
//  ReactiveRegister
//
//  Created by yasoshima on 2018/05/14.
//  Copyright © 2018年 Yuki Yasoshima. All rights reserved.
//

import Foundation

class NumberPad {
    private(set) var amount = NSDecimalNumber.zero {
        didSet {
            if self.amount != oldValue, let handler = self.amountHandler {
                handler(self.amount)
            }
        }
    }
    
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
            self.amount = .zero
        } else {
            self.amount = value
        }
    }
}
