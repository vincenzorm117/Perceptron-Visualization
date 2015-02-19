//
//  main.swift
//  PerceptronTraining
//
//  Created by Vincenzo on 2/15/15.
//  Copyright (c) 2015 Vincenzo. All rights reserved.
//

import Foundation


class perceptron {
    
    var learningRate: Double = 0.0
    var w0: Double = 0.0
    var w1: Double = 0.0
    var w2: Double = 0.0
    var fire = 0
    var total = 0
    
    init(learningRate: Double){
        self.learningRate = learningRate
        w0 = Double( arc4random() % 1000 ) / 2000
        w1 = Double( arc4random() % 1000 ) / 2000
        w2 = Double( arc4random() % 1000 ) / 2000
//        w0 = Double(900)
//        w1 = Double(-1)
//        w2 = Double(-1)
    }
    
    func display(){
        println("w0: \(w0) w1: \(w1) w2: \(w2)")
    }
    
    
    func learn(x1: Double, x2: Double, labelBool: Bool) -> Bool{
        
        var buff = w0 + w1*x1 + w2*x2
        
        let label: Int = (labelBool ? 1 : 0)
        let output: Int = (0.0 < buff ? 1 : 0)
        let outputBool: Bool = (0.0 < buff)
        
        ++total
        if outputBool != labelBool {
            ++fire
            
//            debug(label, output: output, x1: x1, x2: x2)
            
            w0 += learningRate * Double(label - output)
            w1 += learningRate * Double(label - output) * x1
            w2 += learningRate * Double(label - output) * x2
            return true
        }
        return false
    }
    
    func debug(label: Int, output: Int, x1: Double, x2: Double){
        let c0 = learningRate * Double(label - output)
        let c1 = learningRate * Double(label - output) * x1
        let c2 = learningRate * Double(label - output) * x2
        println( String(format: "w0: %7.2f | w1: %7.2f | w2: %7.2f",c0,c1,c2) )
    }
    
}





var andb: [(Double,Double,Int)] = [(250,250,0),(250,500,0),(500,250,0),(500,500,1)]
var orb:  [(Double,Double,Int)] = [(250,250,0),(250,500,1),(500,250,1),(500,500,1)]

var and = [(0,0,0),(0,1,0),(1,0,0),(1,1,1)]
var or  = [(0,0,0),(0,1,1),(1,0,1),(1,1,1)]
var xor = [(0,0,0),(0,1,1),(1,0,1),(1,1,0)]
var top = [(0,0,0),(0,1,1),(1,0,0),(1,1,1)]

var andi = [(0,0,0),(0,-1,0),(-1,0,0),(-1,-1,1)]

var craz: [(Double,Double,Int)] = [(0,0,0),(0,100,0),(50,0,0),(50,100,1)]

var off: [(Double,Double,Int)] = [(15,10,0),(15,44,0),(49,14,0),(67,78,1)]

//var and = [(0,0,0),(0,60,0),(60,0,0),(60,60,1)]
//var or  = [(0,0,0),(0,60,1),(60,0,1),(60,60,1)]
//var xor = [(0,0,0),(0,60,1),(60,0,1),(60,60,0)]
//var top = [(0,0,0),(0,60,1),(60,0,0),(60,60,1)]


func transform(arr: [(Double,Double,Int)]) -> ([(Double,Double,Int)],Double,Double) {
    var maxX: Double = 0.0
    var maxY: Double = 0.0
    for (x,y,_) in arr {
        if maxX < x {
           maxX = x
        }
        if maxY < y {
            maxY = y
        }
    }
    
    var newArr: [(Double,Double,Int)] = []
    
    for (x,y,z) in arr {
        newArr.append( (x/maxX, y/maxY, z) as (Double,Double,Int))
    }
    
    return (newArr,maxX,maxY)
}


func main(){
    
    var p = perceptron(learningRate: Double(0.9))
    var label: Bool
    let example = off
    
    for _ in 0...1000 {
        for (x,y,z) in example {
            label = (z == 1 ? true : false)
            if p.learn(Double(x), x2: Double(y), labelBool: label) {
                break
            }
        }
    }
    
    println( String(format: "%.2f + %.2fx + %.2fy = 0", Double(p.w0),Double(p.w1),Double(p.w2)))
    println("Fire%: \(Double(p.fire)/Double(p.total))")
    
    
    for (x,y,z) in example {
        
        var sum = p.w0 + p.w1*Double(x) + p.w2*Double(y)
        var signSum = (0.0 < sum ? 1 : 0)
        
        if signSum == z {
            println("(\(x),\(y)) success")
        } else {
            println("(\(x),\(y)) fail")
        }
    }
    
}

main()




















