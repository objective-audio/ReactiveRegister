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
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    let register: Register = AppController.shared.register
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.register.numberPad.amount.asObservable().map { "\($0)" }.bind(to: self.amountLabel.rx.text).disposed(by: self.disposeBag)
    }

    @IBAction func inputNumber(sender: UIButton) {
        self.register.numberPad.input(number: sender.tag)
    }
    
    @IBAction func clear(sender: UIButton) {
        self.register.numberPad.clear()
    }
}

