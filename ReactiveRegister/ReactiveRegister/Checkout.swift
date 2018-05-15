//
//  Checkout.swift
//  ReactiveRegister
//
//  Created by yasoshima on 2018/05/14.
//  Copyright © 2018年 Yuki Yasoshima. All rights reserved.
//

import Foundation

class Checkout {
    let menu = Menu()
    var count: Int = 1
    
    var total: NSDecimalNumber {
        return self.menu.price.multiplying(by: NSDecimalNumber(string: "\(self.count)"))
    }
    
    var tax: NSDecimalNumber {
        return .zero
    }
}
