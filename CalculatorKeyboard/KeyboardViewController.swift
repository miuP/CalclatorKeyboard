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
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var answerAndArrowsView: UIView!
    
    
    var isDecimal: Bool = false
    var needClear: Bool = true
    var reveiveInput: Bool = true
    var tagNum: Int = 100
    var isInput: Bool = false
    
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
        self.highlightButton()
    }
    
    
    func highlightButton() {
        println(tagNum)
        var button: UIButton = self.view.viewWithTag(tagNum) as UIButton
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blueColor().CGColor
    }
    
    func disHighlightButton() {
        var button: UIButton = self.view.viewWithTag(tagNum) as UIButton
        button.layer.borderWidth = 0;
        
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
        isInput = true
    }
    
    @IBAction func operatorButtonTapped(sender: AnyObject) {
        if isInput {
            calclator.push(answerLabel.text!)
        }
        needClear = true
        let buttonTitle: String = (sender as UIButton).titleLabel!.text!
        
        if calclator.op  != Calclator.Operator.null {
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
        isInput = false
    }

    @IBAction func equalButtonTapped(sender: AnyObject) {
        if !isInput {
            return
        }
        calclator.push(answerLabel.text!)
        
        if calclator.op  != Calclator.Operator.null {
            answerLabel.text = calclator.getAnswer()
            reveiveInput = false
            operatorLabel.text = ""
        }
        isInput = false
        
    }
    
    @IBAction func clearButtonTapped(sender: AnyObject) {
        if !reveiveInput {
            return
        }
        answerLabel.text = "0"
        needClear = true
        isDecimal = false
        isInput = false
    }
    
    @IBAction func allClearButtonTapped(sender: AnyObject) {
        answerLabel.text = "0"
        calclator = Calclator()
        reveiveInput = true
        needClear = true
        isInput = false
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
    
    @IBAction func upKeyTapped(sender: AnyObject) {
        disHighlightButton()
        tagNum += 100
        if tagNum >= 500 {
            tagNum = tagNum - 400
        }
        
        if (tagNum == 204) {
            tagNum = 404
        }
        
        highlightButton()
    }
    
    @IBAction func rightKeyTapped(sender: AnyObject) {
        disHighlightButton()
        tagNum += 1
        if tagNum%100 == 5 {
            tagNum -= 5
        }
        
        if tagNum == 204 {
            tagNum = 104
        }
        
        if tagNum == 304 {
            tagNum = 404
        }
        highlightButton()
    }
    
    @IBAction func downKeyTapped(sender: AnyObject) {
        disHighlightButton()
        tagNum -= 100
        
        if tagNum < 100 {
            tagNum += 400
        }
        
        if tagNum == 204 {
            tagNum = 104
        }
        
        if tagNum == 304 {
            tagNum = 404
        }
        
        highlightButton()
    }
    
    @IBAction func leftKeyTapped(sender: AnyObject) {
        disHighlightButton()
        tagNum -= 1
        
        if tagNum%100 == 99 {
            tagNum += 5
        }
        
        if tagNum == 204 {
            tagNum = 104
        }
        
        if tagNum == 304 {
            tagNum = 404
        }
        
        highlightButton()
    }
    
    
    @IBAction func enterKeyTapped(sender: AnyObject) {
        var button: UIButton = self.view.viewWithTag(tagNum) as UIButton
        switch tagNum {
        case 100, 200...202, 300...302, 400...402:
            numberButtonTapped(button)
        case 103, 203, 303, 403:
            operatorButtonTapped(button)
        case 104:
            allClearButtonTapped(button)
        case 404:
            clearButtonTapped(button)
        case 102:
            equalButtonTapped(button)
        case 101:
            decimalPointButtonTapped(button)
        default:
            break
        }
    }
    
    @IBAction func toggleViewButtonTapped(sender: AnyObject) {
        let buttonsViewFrame: CGRect = buttonsView.frame
        let answerAndArrowsViewFrame: CGRect = answerAndArrowsView.frame
        
        UIView.animateWithDuration(
            1.0,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: {
                self.buttonsView.frame = answerAndArrowsViewFrame;
                self.answerAndArrowsView.frame = buttonsViewFrame
            },
            completion:{
                (value: Bool) in
                println("Animation End");
            }
        );
    }
   
    @IBAction func inputButtonTapped(sender: AnyObject) {
        (self.textDocumentProxy as UIKeyInput).insertText(answerLabel.text!)
        
    }
    
}
