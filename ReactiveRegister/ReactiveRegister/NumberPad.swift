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
    
    class Number {
        private(set) var string: String = ""
        
        var amount: NSDecimalNumber {
            let value = NSDecimalNumber(string: self.string)
            
            if value == .notANumber {
                return .zero
            } else {
                return value
            }
        }
        
        func input(command: Command) -> NSDecimalNumber {
            switch command {
            case .number(let number):
                self.string = self.string + "\(number)"
            case .clear:
                self.string = ""
            }
            
            return self.amount
        }
    }
    
    private let amountRelay = BehaviorRelay<NSDecimalNumber>(value: .zero)
    var amount: Observable<NSDecimalNumber> { return self.amountRelay.asObservable() }
    
    let input = PublishRelay<Command>()
    
    let disposeBag = DisposeBag()
    
    init() {
        let number = Number()
        self.input.asObservable().map { number.input(command: $0) }.bind(to: self.amountRelay).disposed(by: self.disposeBag)
    }
}
