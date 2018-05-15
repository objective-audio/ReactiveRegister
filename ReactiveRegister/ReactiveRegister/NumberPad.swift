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
    
    private let amountSubject = BehaviorSubject<NSDecimalNumber>(value: .zero)
    var amount: Observable<NSDecimalNumber> { return self.amountSubject }
    
    let input = PublishSubject<Command>()
    
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
            }.bind(to: self.amountSubject).disposed(by: self.disposeBag)
    }
}
