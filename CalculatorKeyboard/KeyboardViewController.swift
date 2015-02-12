//
//  KeyboardViewController.swift
//  CalculatorKeyboard
//
//  Created by kazuya on 1/26/15.
//  Copyright (c) 2015 COINS Project AID. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    
    var isDecimal: Bool = false
    var needClear: Bool = true
    var reveiveInput: Bool = true
    
    var calclator = Calclator()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var keyboardView = UINib(nibName:"CalculatorKeyboardView", bundle:nil).instantiateWithOwner(self,options:nil)[0] as UIView
        self.inputView.addSubview(keyboardView)
        answerLabel.font = UIFont(name:"DBLCDTempBlack", size:25.0)
        operatorLabel.text = ""
    }
    
    
    @IBAction func numberButtonTapped(sender: AnyObject) {
        if !reveiveInput {
            return
        }
        let input: UIButton! = sender as UIButton
        if needClear {
            answerLabel.text = ""
            needClear = false
        }
        if answerLabel.text?.utf16Count < 10 {
            answerLabel.text = answerLabel.text! + input.titleLabel!.text!
        }
    }
    
    @IBAction func operatorButtonTapped(sender: AnyObject) {
        calclator.push(answerLabel.text!)
        needClear = true
        let buttonTitle: String = (sender as UIButton).titleLabel!.text!
        if calclator.op  != Calclator.Operator.null {
            println(calclator.op)
            answerLabel.text = calclator.getAnswer()
        }
        
        switch buttonTitle {
            case "+":
                calclator.op = Calclator.Operator.add
            case "-":
                calclator.op = Calclator.Operator.sub
            case "×":
                calclator.op = Calclator.Operator.mul
            case "÷":
                calclator.op = Calclator.Operator.div
            default:
                break
        }
        operatorLabel.text = buttonTitle
        reveiveInput = true
        isDecimal = false
    }

    @IBAction func equalButtonTapped(sender: AnyObject) {
        calclator.push(answerLabel.text!)
        
        if calclator.op  != Calclator.Operator.null {
            answerLabel.text = calclator.getAnswer()
            reveiveInput = false
            operatorLabel.text = ""
        }
        
    }
    
    @IBAction func clearButtonTapped(sender: AnyObject) {
        if !reveiveInput {
            return
        }
        answerLabel.text = "0"
        needClear = true
        isDecimal = false
    }
    
    @IBAction func allClearButtonTapped(sender: AnyObject) {
        answerLabel.text = "0"
        calclator = Calclator()
        reveiveInput = true
        needClear = true
    }
    
    @IBAction func decimalPointButtonTapped(sender: AnyObject) {
        if !isDecimal {
            answerLabel.text = answerLabel.text! + "."
        }
        isDecimal = true
    }
    

    @IBAction func nextKeyboardButtonTapped(sender: AnyObject) {
        self.advanceToNextInputMode()
    }
    
    
}
