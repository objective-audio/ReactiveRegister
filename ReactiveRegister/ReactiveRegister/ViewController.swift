//
//  ViewController.swift
//  ReactiveRegister
//
//  Created by yasoshima on 2018/05/11.
//  Copyright © 2018年 Yuki Yasoshima. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    let register: Register = AppController.shared.register
    var checkout: Checkout { return  self.register.checkout }
    var numberPad: NumberPad { return self.register.numberPad }
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.register.checkout.total.map { "合計 : \($0)" }.bind(to: self.totalLabel.rx.text).disposed(by: self.disposeBag)
        self.register.checkout.count.map { "りんご x \($0)個" }.bind(to: self.countLabel.rx.text).disposed(by: self.disposeBag)
        
        self.register.numberPad.amount.asObservable().map { "支払い : \($0)" }.bind(to: self.paymentLabel.rx.text).disposed(by: self.disposeBag)
        
        for idx in 0..<10 {
            self.numberButtons[idx].rx.tap.asSignal().map { NumberPad.Command.number(idx) }.emit(to: self.numberPad.input).disposed(by: self.disposeBag)
        }
        
        self.clearButton.rx.tap.asSignal().map { NumberPad.Command.clear }.emit(to: self.numberPad.input).disposed(by: self.disposeBag)
    }
}

