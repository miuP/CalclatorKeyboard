//
//  Calclator.swift
//  CalculatorKeyboardApp
//
//  Created by kazuya on 1/29/15.
//  Copyright (c) 2015 COINS Project AID. All rights reserved.
//

import UIKit

class Calclator {
    
    enum Operator {
        case add
        case sub
        case mul
        case div
    }
    
    var firstNum: Double!
    var secondNum: Double!
    var op: Operator!
    
    
    init() {
        firstNum = nil
        secondNum = nil
        op = Operator.add
    }
    
    private class func isDouble(num: Double) -> Bool {
        if num%1 != 0 {
            return true
        }
        return false
    }
    
    private func calclate() -> Double {
        switch self.op! {
            case Operator.add: return self.firstNum + self.secondNum
            case Operator.sub: return self.firstNum - self.secondNum
            case Operator.mul: return self.firstNum * self.secondNum
            case Operator.div: return self.firstNum / self.secondNum
            default: break
        }
    }
    
    func getAnswer() -> String {
        if firstNum != nil && secondNum != nil {
            let result = calclate()
            firstNum = result
            secondNum = nil
            op = nil
            if Calclator.isDouble(result) {
                return String(format: "%f", result)
            } else {
                return String(format: "%d", Int(result))
            }
        }
        return ""
    }
    
    func push(string: String) -> Bool {
        if firstNum == nil {
            firstNum = (string as NSString).doubleValue
            return true
        }
        if secondNum == nil {
            secondNum = (string as NSString).doubleValue
            return true
        }
        return false
    }
    
    
}
