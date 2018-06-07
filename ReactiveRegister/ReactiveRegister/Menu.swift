//
//  Menu.swift
//  ReactiveRegister
//
//  Created by yasoshima on 2018/05/14.
//  Copyright © 2018年 Yuki Yasoshima. All rights reserved.
//

import Foundation
import Bond

class Menu {
    let price = Observable<NSDecimalNumber>(NSDecimalNumber(string: "100"))
    let taxRate = Observable<Int>(8)
    let name = Observable<String>("りんご")
}
