//
//  Calculator.swift
//  ReactiveRegister
//
//  Created by yasoshima on 2018/05/14.
//  Copyright © 2018年 Yuki Yasoshima. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class NumberPad {
    enum Command {
        case number(Int)
        case clear
    }
    
    var amount = BehaviorRelay<NSDecimalNumber>(value: .zero)
    
    private var input: String = "" {
        didSet {
            if self.input != oldValue {
                self.updateAmount()
            }
        }
    }
    
    func input(_ command: Command) {
        switch command {
        case .number(let number):
            self.input = self.input + "\(number)"
        case .clear:
            self.input = ""
        }
    }
    
    private func updateAmount() {
        let value = NSDecimalNumber(string: self.input)
        if value == .notANumber {
            self.amount.accept(.zero)
        } else {
            self.amount.accept(value)
        }
    }
}
