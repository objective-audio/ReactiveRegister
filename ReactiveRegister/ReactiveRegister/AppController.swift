//
//  AppController.swift
//  ReactiveRegister
//
//  Created by yasoshima on 2018/05/14.
//  Copyright © 2018年 Yuki Yasoshima. All rights reserved.
//

import Foundation

class AppController {
    static let shared = AppController()
    
    let register = Register()
    
    private init() {}
}
