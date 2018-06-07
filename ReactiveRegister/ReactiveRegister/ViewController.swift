//
//  ViewController.swift
//  ReactiveRegister
//
//  Created by yasoshima on 2018/05/11.
//  Copyright © 2018年 Yuki Yasoshima. All rights reserved.
//

import UIKit
import Bond
import ReactiveKit

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
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Model to View
        
        self.viewModel.totalText.bind(to: self.totalLabel.reactive.text).dispose(in: self.disposeBag)
        self.viewModel.taxText.bind(to: self.taxLabel.reactive.text).dispose(in: self.disposeBag)
        self.viewModel.changeText.bind(to: self.changeLabel.reactive.text).dispose(in: self.disposeBag)
        self.viewModel.paymentText.bind(to: self.paymentLabel.reactive.text).dispose(in: self.disposeBag)
        self.viewModel.countText.bind(to: self.countLabel.reactive.text).dispose(in: self.disposeBag)
        self.viewModel.countValue.bind(to: self.stepper.reactive.value).dispose(in: self.disposeBag)
        self.viewModel.canEnter.bind(to: self.enterButton.reactive.isEnabled).dispose(in: self.disposeBag)
        
        // View to Model

        let observeCommand = { [weak self] command -> Void in self?.viewModel.input(command: command) }
        
        for idx in 0..<10 {
            self.numberButtons[idx].reactive.tap.map { NumberPad.Command.number(idx) }.observeNext(with: observeCommand).dispose(in: self.disposeBag)
        }
        
        self.clearButton.reactive.tap.map { NumberPad.Command.clear }.observeNext(with: observeCommand).dispose(in: self.disposeBag)
        self.delButton.reactive.tap.map { NumberPad.Command.delete }.observeNext(with: observeCommand).dispose(in: self.disposeBag)
        
        self.stepper.reactive.value.map { Int($0) }.bind(to: self.viewModel.count).dispose(in: self.disposeBag)

        self.enterButton.reactive.tap.observeNext { [weak self] _ in
            guard let sself = self else {
                return
            }
            let actionSheet = UIAlertController(title: "お買い上げありがとうございます！", message: "", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "閉じる", style: .default, handler: { [weak self] _ in self?.viewModel.reset() }))
            actionSheet.popoverPresentationController?.sourceView = sself.enterButton
            actionSheet.popoverPresentationController?.sourceRect = sself.enterButton.bounds
            self?.present(actionSheet, animated: true, completion: nil)
        }.dispose(in: self.disposeBag)
    }
}

