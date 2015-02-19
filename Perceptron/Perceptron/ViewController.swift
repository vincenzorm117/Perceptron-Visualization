//
//  ViewController.swift
//  Perceptron
//
//  Created by Vincenzo on 2/14/15.
//  Copyright (c) 2015 Vincenzo. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {

    @IBOutlet weak var learningRate: NSSlider!
    @IBOutlet weak var learningRateDisplay: NSTextField!
    @IBOutlet weak var examples: NSPopUpButton!
    @IBOutlet weak var iterations: NSTextField!
    @IBOutlet weak var canvas: Graph!
    @IBOutlet weak var totalDisplay: NSTextField!
    @IBOutlet weak var wrongDisplay: NSTextField!
    @IBOutlet weak var errorDisplay: NSTextField!
    @IBOutlet weak var updateGraphButton: NSButton!

    
    // Examples
    var and = [(0,0,0),(0,60,0),(60,0,0),(60,60,1)]
    var or  = [(0,0,0),(0,60,1),(60,0,1),(60,60,1)]
    var xor = [(0,0,0),(0,60,1),(60,0,1),(60,60,0)]
    var top = [(0,0,0),(0,60,1),(60,0,0),(60,60,1)]
    
    @IBAction func changeLearningRate(sender: AnyObject) {
        var x : Double
        x = learningRate.doubleValue / 200
        learningRateDisplay.stringValue = "\(x)"
    }
    
    @IBAction func updateCanvas(sender: AnyObject) {
        let count = canvas.updateBoundary()
        canvas.display()
        
        if count == 0 {
            updateGraphButton.title = "Update Graph"
        } else {
            updateGraphButton.title = "Update Graph (\(count))"
        }
    }
    
    
    @IBAction func learn(sender: AnyObject) {
        
        canvas.clearHistory()
        
       var p = perceptron(learningRate: CGFloat(self.learningRate.doubleValue / 200) )
        
        var iter: Int = self.iterations.integerValue
        var x1: Double
        var x2: Double
        

        for i in 0...iter {
            
            for (x,y) in self.canvas.teamRed {
                p.learn(x, x2: y, labelBool: true, width: self.canvas.bounds.width, height: self.canvas.bounds.height)
            }
            for (x,y) in self.canvas.teamBlue {
                p.learn(x, x2: y, labelBool: false, width: self.canvas.bounds.width, height: self.canvas.bounds.height)
            }
            
            
            
            
            if i % (iter / 10) == 0 {
                self.canvas.drawBoundary(p.w0, w1: p.w1, w2: p.w2)
            }
            updateGraphButton.title = "Update Graph (10)"
        }
        
        
        var error = p.test(self.canvas.teamRed, blueTeam: self.canvas.teamBlue, w: self.canvas.bounds.width, h: self.canvas.bounds.height)
        self.errorDisplay.stringValue = String(format: "Error: %3.3f %%", error.0 / error.1 * 100)
        self.totalDisplay.stringValue = "Total: \(Int(error.1))"
        self.wrongDisplay.stringValue = "Incorrect: \(Int(error.0))"
        
        
        
    }
    
    
    @IBAction func clear(sender: AnyObject) {
        canvas.clear()
        updateGraphButton.title = "Update Graph"
    }
    
    @IBAction func selectExample(sender: AnyObject) {
        canvas.clearWeights()
        
        var temp: (CGFloat,CGFloat) = (0,0)
        
        var arr: [(Int,Int,Int)]?
        
        
        
        switch examples.titleOfSelectedItem! {
            case "and":
                arr = and
            case "or":
                arr = or
            case "xor":
                arr = xor
            case "top":
                arr = top
            default:
                arr = nil
        }
        
        
        if arr != nil {
            for (x,y,l) in arr! {
                temp.0 = CGFloat(x) + canvas.bounds.width / 2
                temp.1 = CGFloat(y) + canvas.bounds.height / 2
                
                if l == 1 {
                    canvas.teamRed.append(temp as (CGFloat,CGFloat))
                } else {
                    canvas.teamBlue.append(temp as (CGFloat,CGFloat))
                }
                
                canvas.needsDisplay = true
            }
        }
    
    }
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.wrongDisplay.stringValue = ""
        self.totalDisplay.stringValue = ""
        self.errorDisplay.stringValue = ""
        
        // Setup Pop Up button
        examples.removeAllItems()
        let ex = ["and","or","xor","top"]
        for var i = 0; i < ex.count; i++ {
            examples.insertItemWithTitle(ex[i], atIndex: i);
        }
        
        // Setup learning rate
        var x : Double
        x = learningRate.doubleValue / 200
        learningRateDisplay.stringValue = "\(x)"
        
        
        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.

        }
    }


}

