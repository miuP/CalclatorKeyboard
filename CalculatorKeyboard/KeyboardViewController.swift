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

    override func updateViewConstraints() {
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var keyboardView = UINib(nibName:"CalculatorKeyboardView", bundle:nil).instantiateWithOwner(self,options:nil)[0] as UIView
        self.inputView.addSubview(keyboardView)
        
    }

    @IBAction func nextKeyboardButtonTapped(sender: AnyObject) {
        self.advanceToNextInputMode()
    }
    

}
