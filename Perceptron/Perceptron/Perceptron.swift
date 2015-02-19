//
//  Perceptron.swift
//  Perceptron
//
//  Created by Vincenzo on 2/14/15.
//  Copyright (c) 2015 Vincenzo. All rights reserved.
//

import Foundation


class perceptron {
    
    var learningRate: CGFloat = 0.0
    var w0: CGFloat = 0.0
    var w1: CGFloat = 0.0
    var w2: CGFloat = 0.0
    
    init(learningRate: CGFloat){
        self.learningRate = learningRate
        w0 = CGFloat( arc4random() % 1000 ) / 2000
        w1 = CGFloat( arc4random() % 1000 ) / 2000
        w2 = CGFloat( arc4random() % 1000 ) / 2000
    }
    
    func display(equation: Bool){
        if equation {
            println("\(w0) + \(w1)x + \(w2)y = 0")
        } else {
            print("w0: \(w0) w1: \(w1) w2: \(w2) ")
        }
    }
    
    func sigmoid(x: CGFloat) -> CGFloat {
        return 1.0 / (1.0 + exp(-x))
    }
    
    func learn(x1: CGFloat, x2: CGFloat, labelBool: Bool, width: CGFloat, height: CGFloat){
        
        var buff = w0 + w1*x1/width + w2*x2/height
        
        let label: Int = (labelBool ? 1 : 0)
        let output: Int = (0.0 < buff ? 1 : 0)
        let outputBool: Bool = (0.0 < buff)
        
        if outputBool != labelBool {
            w0 += learningRate * CGFloat(label - output)
            w1 += learningRate * CGFloat(label - output) * x1
            w2 += learningRate * CGFloat(label - output) * x2
        }
        
    }
    
    func test(redTeam: [(CGFloat,CGFloat)], blueTeam: [(CGFloat,CGFloat)], w: CGFloat, h: CGFloat) -> (Double,Double) {
        
        var error: Double = 0.0
        var total: Double = Double(redTeam.count + blueTeam.count)
        
        for (x,y) in redTeam {
            var signSum = (0.0 < w0*w*h + w1*h*x + w2*w*y ? 1 : 0)
            
            if signSum != 1 {
                ++error
            }
        }
        
        for (x,y) in blueTeam {
            var signSum = (0.0 < w0*w*h + w1*h*x + w2*w*y ? 1 : 0)
            
            if signSum != 0 {
                ++error
            }
        }
        
        return (error,total)
    }
    
}