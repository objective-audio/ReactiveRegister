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
    @IBOutlet weak var delButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    let register: Register = AppController.shared.register
    var checkout: Checkout { return  self.register.checkout }
    var numberPad: NumberPad { return self.register.numberPad }
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Model to View
        
        self.checkout.total.map { "合計 : \($0) 円" }.bind(to: self.totalLabel.rx.text).disposed(by: self.disposeBag)
        self.checkout.tax.map { "税 : \($0) 円" }.bind(to: self.taxLabel.rx.text).disposed(by: self.disposeBag)
        self.checkout.count.map { "りんご x \($0) 個" }.bind(to: self.countLabel.rx.text).disposed(by: self.disposeBag)
        self.checkout.count.map { Double($0) }.bind(to: self.stepper.rx.value).disposed(by: self.disposeBag)
        self.checkout.change.map { "お釣り : \($0) 円" }.bind(to: self.changeLabel.rx.text).disposed(by: self.disposeBag)
        self.numberPad.amount.asObservable().map { "支払い : \($0)" }.bind(to: self.paymentLabel.rx.text).disposed(by: self.disposeBag)
        self.checkout.canEnter.bind(to: self.enterButton.rx.isEnabled).disposed(by: self.disposeBag)
        
        // View to Model
        
        for idx in 0..<10 {
            self.numberButtons[idx].rx.tap.asSignal().map { NumberPad.Command.number(idx) }.emit(to: self.numberPad.input).disposed(by: self.disposeBag)
        }
        
        self.clearButton.rx.tap.asSignal().map { NumberPad.Command.clear }.emit(to: self.numberPad.input).disposed(by: self.disposeBag)
        self.delButton.rx.tap.asSignal().map { NumberPad.Command.delete }.emit(to: self.numberPad.input).disposed(by: self.disposeBag)
        self.stepper.rx.value.asDriver().map { Int($0) }.drive(self.checkout.count).disposed(by: self.disposeBag)
        self.enterButton.rx.tap.subscribe(onNext: { [weak self] _ in
            let actionSheet = UIAlertController(title: "お買い上げありがとうございます！", message: "", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "閉じる", style: .default, handler: { [weak self] _ in self?.register.resetRelay.accept(Void()) }))
            self?.present(actionSheet, animated: true, completion: nil)
        }).disposed(by: self.disposeBag)
    }
}

