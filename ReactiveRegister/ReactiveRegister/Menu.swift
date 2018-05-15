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
    let tax = BehaviorRelay<NSDecimalNumber>(value: NSDecimalNumber(string: "8"))
    let name = BehaviorRelay<String>(value: "りんご")
}
