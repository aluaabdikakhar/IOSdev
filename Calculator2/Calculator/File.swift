//
//  File.swift
//  Calculator
//
//  Created by apple on 2/22/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation

class File {
    // MARK: - Constants
    enum Operation {
        case allclear
        case equals
        case unary(function: (Double) -> Double)
        case binary(function: (Double, Double) -> Double)
    }
    
    var map: [String : Operation] = [
        "+" : .binary { $0 + $1 },
        "x" : .binary { $0 * $1 },
        "-" : .binary { $0 - $1 },
        "/" : .binary { $0 / $1 },
        "=" : .equals,
        "AC" : .allclear,
        "%" : .unary { $0 / 100 },
        "+/-" : .unary{ $0 * (-1) }
    ]
        
    // MARK: - Variables
    var result: Double = 0
    var lastBinaryOperation: ((Double, Double) -> Double)?
    var reminder: Double = 0
    
    // MARK: - Methods
    func setOperand(number: Double) {
        result = number
    }
    
    func executeOperation(symbol: String) {
        guard let operation = map[symbol] else {
            print("ERROR: no such symbol in map")
            return
        }
        
        switch operation {
        case .unary(let function):
            if symbol == "%"{
                if reminder == 0{
                    result = function(result)
                }else {
                    result = reminder * function(result)
                }
            }else{
                result = function(result)
            }
        case .binary(let function):
            if lastBinaryOperation != nil{
                executeOperation(symbol: "=")
                reminder=result
            }
            else{
                reminder=result
            }
            lastBinaryOperation = function
        case .equals:
            if let lastOperation = lastBinaryOperation {
                result = lastOperation(reminder, result)
                lastBinaryOperation = nil
                reminder = 0
            }
        case .allclear:
            result = 0
            lastBinaryOperation = nil
            reminder = 0
        }
    }
}

