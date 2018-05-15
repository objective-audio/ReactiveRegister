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
    
    private let amountRelay = BehaviorRelay<NSDecimalNumber>(value: .zero)
    var amount: Observable<NSDecimalNumber> { return self.amountRelay.asObservable() }
    
    let input = PublishRelay<Command>()
    
    let disposeBag = DisposeBag()
    
    init() {
        var inputString: String = ""
        
        self.input.asObservable().map { command in
            switch command {
            case .number(let number):
                inputString = inputString + "\(number)"
            case .clear:
                inputString = ""
            }
            
            let value = NSDecimalNumber(string: inputString)
            
            if value == .notANumber {
                return .zero
            } else {
                return value
            }
            }.bind(to: self.amountRelay).disposed(by: self.disposeBag)
    }
}
