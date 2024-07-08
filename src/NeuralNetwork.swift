//
//  main.swift
//  NeuralNetwork2
//
//  Created by Vincenzo on 2/18/15.
//  Copyright (c) 2015 Vincenzo. All rights reserved.
//

import Foundation

let time = UInt32(NSDate().timeIntervalSinceReferenceDate)
srandom(time)

class net {
    
    // Values
    var input:  [Double]
    var hidden: [Double]
    var output:  Double
    
    // Weights
    var wih: [[Double]]
    var who: [Double]
    
    let lr_ih: Double
    let lr_ho: Double
    
    
    func vrand() -> Double {
        return Double(random()) / Double(RAND_MAX)
    }
    
    init(hiddenCount: Int, lr_ih: Double, lr_ho: Double){
        self.lr_ih = lr_ih
        self.lr_ho = lr_ho
        
        // Init values
        input = Array(count: 3, repeatedValue: 0.0)
        hidden = Array(count: hiddenCount, repeatedValue: 0.0)
        output = 0.0
        
        // Init weights
        wih = Array(count: 3, repeatedValue: Array(count: hiddenCount, repeatedValue: 0.0))
        who = Array(count: hiddenCount, repeatedValue: 0.0)
        
        //        println("Weights:")
        for i in 0..<wih.count {
            for j in 0..<hiddenCount {
                wih[i][j] = vrand()
                //                println("whi[\(i),\(j)] = \(wih[i][j])")
            }
        }
        
        for i in 0..<hiddenCount {
            who[i] = vrand()
            //            println("who[\(i)] = \(who[i])")
        }
        
        
    }
    
    
    func feedForward(inputs: (Double,Double)) -> Double {
        
        input[0] = inputs.0
        input[1] = inputs.1
        input[2] = 1.0
        
        
        var buff: Double
        
        for i in 0..<hidden.count {
            buff = 0.0
            for j in 0..<input.count {
                buff += wih[j][i] * input[j]
            }
            hidden[i] = tanh(buff)
        }
        
        buff = 0.0
        for i in 0..<hidden.count {
            buff += who[i] * hidden[i]
        }
        output = buff
        
        
        
        return output
    }
    
    
    func backProp(label: Double) -> Double{
        
        let error = output - label
        
        for i in 0..<hidden.count {
            who[i] = who[i] - lr_ho * error * hidden[i]
            
            // Regularizer
            //            if who[i] > 5.0 {
            //                who[i] = 5.0
            //            } else if who[i] < -5.0 {
            //                who[i] = -5.0
            //            }
        }
        
        
        for i in 0..<hidden.count {
            for j in 0..<input.count {
                var buff =  1.0 - (hidden[i]*hidden[i])
                buff = buff * who[i] * error * lr_ih
                buff = buff * input[j]
                wih[j][i] = wih[j][i] - buff
            }
        }
        
        return error
    }
    
    
    func train(inputs: [(Double,Double,Double)], iterations: Int, progress: Bool = false){
        
        for i in 1...iterations {
            
            for j in 0..<inputs.count {
                feedForward((inputs[j].0,inputs[j].1))
                backProp(inputs[j].2)
            }
            
            if i % Int(Double(iterations) / 5) == 0 && progress {
                println("Progress: \(Int(Double(i)/Double(iterations)*100)) %")
            }
        }
    }
    
    
    func test(inputs: [(Double,Double,Double)]) {
        
        println("Results:")
        var output: Double
        for n in inputs {
            output = feedForward((n.0,n.1))
            println("\(n): \(output)")
        }
    }
}


let and: [(Double,Double,Double)] = [(0,0,0),(0,1,0),(1,0,0),(1,1,1)]
let or:  [(Double,Double,Double)] = [(0,0,0),(0,1,1),(1,0,1),(1,1,1)]
let xor: [(Double,Double,Double)] = [(0,0,0),(0,1,1),(1,0,1),(1,1,0)]
let top: [(Double,Double,Double)] = [(0,0,0),(0,1,1),(1,0,0),(1,1,1)]

let test = xor


var n = net(hiddenCount: 2, lr_ih: 0.7, lr_ho: 0.07)

n.train(test, iterations: 1000, progress: false)

n.test(test)
































