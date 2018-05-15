//
//  Menu.swift
//  ReactiveRegister
//
//  Created by yasoshima on 2018/05/14.
//  Copyright © 2018年 Yuki Yasoshima. All rights reserved.
//

import Foundation
import RxCocoa

class Menu {
    let price = BehaviorRelay<NSDecimalNumber>(value: NSDecimalNumber(string: "100"))
    let taxRate = BehaviorRelay<Int>(value: 8)
    let name = BehaviorRelay<String>(value: "りんご")
}
