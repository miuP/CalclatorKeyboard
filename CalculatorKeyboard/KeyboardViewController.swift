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
    var isDecimal : Bool = false
    
    var calclator = Calclator()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var keyboardView = UINib(nibName:"CalculatorKeyboardView", bundle:nil).instantiateWithOwner(self,options:nil)[0] as UIView
        self.inputView.addSubview(keyboardView)
    }
    
    
    @IBAction func numberButtonTapped(sender: AnyObject) {
        let input: UIButton! = sender as UIButton
        if answerLabel.text?.utf16Count < 10 {
            answerLabel.text = answerLabel.text! + input.titleLabel!.text!
        }
    }
    
    @IBAction func operatorButtonTapped(sender: AnyObject) {
        calclator.push(answerLabel.text!)
        answerLabel.text = ""
        let buttonTitle: String = (sender as UIButton).titleLabel!.text!
        
        if calclator.op != nil {
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
        
        
        
        isDecimal = false
    }

    @IBAction func equalButtonTapped(sender: AnyObject) {
        answerLabel.text = ""
    }
    
    @IBAction func clearButtonTapped(sender: AnyObject) {
        answerLabel.text = ""
        isDecimal = false
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
