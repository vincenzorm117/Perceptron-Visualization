//
//  Graph.swift
//  Perceptron
//
//  Created by Vincenzo on 2/14/15.
//  Copyright (c) 2015 Vincenzo. All rights reserved.
//
import AppKit
import Foundation
import Cocoa



class Graph: NSView {

    var teamRed: [(CGFloat,CGFloat)] = []
    var teamBlue: [(CGFloat,CGFloat)] = []
    
    var hasSelectedExample: Bool = false
    var clearCanvas: Bool = false
    var lineDrawn: Bool = false
    let line: CGFloat = 4
    let offset: CGFloat = 20
    var drawBoundary = false
//    var w0: CGFloat = 0.0
//    var w1: CGFloat = 0.0
//    var w2: CGFloat = 0.0
    
    var w0: [CGFloat] = []
    var w1: [CGFloat] = []
    var w2: [CGFloat] = []
    
    var lastw0: CGFloat = 0.0
    var lastw1: CGFloat = 0.0
    var lastw2: CGFloat = 0.0
    
    func clearHistory(){
        w0 = []
        w1 = []
        w2 = []
    }
    
    func clearWeights(){
        teamRed = []
        teamBlue = []
    }
    
    func clear(){
        clearWeights()
        clearCanvas = true
        needsDisplay = true
    }
    
    func updateBoundary() -> Int {
        return w0.count
    }
    
    func setGrid(){
    
        // Fill Background with white
        NSColor.whiteColor().set()
        NSRectFill(self.bounds)
        
        // Draw Y-Axis
        NSColor.grayColor().set()
        let yAxis = NSBezierPath()
        yAxis.moveToPoint(NSMakePoint(self.bounds.width/2, 0))
        yAxis.lineToPoint(NSPoint(x: self.bounds.width/2, y: self.bounds.height))
        yAxis.lineWidth = 1
        yAxis.stroke()

        // Draw X-Axis
        NSColor.grayColor().set()
        let xAxis = NSBezierPath()
        xAxis.moveToPoint(NSMakePoint(0, self.bounds.height/2))
        xAxis.lineToPoint(NSPoint(x: self.bounds.width, y: self.bounds.height/2))
        xAxis.lineWidth = 1
        xAxis.stroke()

        let width = Double(self.bounds.width)
        let height = Double(self.bounds.height)
        let numBars = 20
        let bar = NSBezierPath()
        NSColor.blackColor().set()
        bar.lineWidth = 1;

//        // Draw Horizontal bars
//        for(var i = 1; i <= numBars; i++){
//            var x = CGFloat(Double(i)*width / Double(numBars))
//            var y = CGFloat(height/2)
//            bar.moveToPoint(NSMakePoint(x,y-2))
//            bar.lineToPoint(NSMakePoint(x, y+2))
//            bar.stroke()
//        }
//        
//        // Draw Vertical bars
//        for(var i = 1; i <= numBars; i++){
//            var x = CGFloat(width/2)
//            var y = CGFloat(Double(i)*height / Double(numBars))
//            bar.moveToPoint(NSMakePoint(x-2, y))
//            bar.lineToPoint(NSMakePoint(x+2, y))
//            bar.stroke()
//        }
        
    }
    
    
    
    override func mouseDown(theEvent: NSEvent) {
        super.mouseDown(theEvent)
        
        let x: CGFloat = theEvent.locationInWindow.x - offset
        let y: CGFloat = theEvent.locationInWindow.y - offset
        
        teamRed.append((x,y))
        
        needsDisplay = true
    }
    
    override func rightMouseDown(theEvent: NSEvent) {
        super.rightMouseDown(theEvent)
        
        let x: CGFloat = theEvent.locationInWindow.x - offset
        let y: CGFloat = theEvent.locationInWindow.y - offset
        
        teamBlue.append((x,y))
        
        needsDisplay = true
    }
    
    func drawBoundary(w0: CGFloat, w1: CGFloat, w2: CGFloat){

        self.w0.append(w0)
        self.w1.append(w1)
        self.w2.append(w2)
        
        drawBoundary = true
        needsDisplay = true
    }
    
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        
        // Drawing code here.
        setGrid()
        
        if clearCanvas {
            w0 = []
            w1 = []
            w2 = []
            lastw0 = 0.0
            lastw1 = 0.0
            lastw2 = 0.0
            clearCanvas = false
            return
        }
        
        // Draw boundary line
        var cross: NSBezierPath
        
        if 0 < w0.count {
            lineDrawn = true
            
            let w0 = self.w0.removeAtIndex(0)
            let w1 = self.w1.removeAtIndex(0)
            let w2 = self.w2.removeAtIndex(0)
            
            lastw0 = w0
            lastw1 = w1
            lastw2 = w2
            
            
            NSColor.greenColor().set()
            cross = NSBezierPath()
            cross.lineWidth = 1
            
            let source: CGFloat = -w0 * bounds.height / w2
            let dest: CGFloat   = -w0 * bounds.height / w2 - w1 * bounds.height / w2
    //            let dest: CGFloat   = -w0 * bounds.height / w2 - bounds.width * w1 * bounds.height / w2 / bounds.width
            

            cross.moveToPoint(NSMakePoint(CGFloat(0.0), source))
            cross.lineToPoint(NSMakePoint(CGFloat(bounds.width), dest))
            cross.stroke()
            cross.closePath()

        
        } else if lineDrawn && lastw0 != 0.0 && lastw1 != 0.0 && lastw2 != 0.0 {
            let w0 = lastw0
            let w1 = lastw1
            let w2 = lastw2
            
            NSColor.greenColor().set()
            cross = NSBezierPath()
            cross.lineWidth = 1
            
            let source: CGFloat = -w0 * bounds.height / w2
            let dest: CGFloat   = -w0 * bounds.height / w2 - w1 * bounds.height / w2
            //            let dest: CGFloat   = -w0 * bounds.height / w2 - bounds.width * w1 * bounds.height / w2 / bounds.width
            
            
            cross.moveToPoint(NSMakePoint(CGFloat(0.0), source))
            cross.lineToPoint(NSMakePoint(CGFloat(bounds.width), dest))
            cross.stroke()
            cross.closePath()
        }
        
        
        // Draw Points

        NSColor.redColor().setStroke()
        for (x,y) in teamRed {
            cross = NSBezierPath()
            cross.lineWidth = 3
            
            cross.moveToPoint(NSMakePoint(x-line, y))
            cross.lineToPoint(NSMakePoint(x+line, y))
            cross.stroke()
            
            cross.moveToPoint(NSMakePoint(x, y-line))
            cross.lineToPoint(NSMakePoint(x, y+line))
            cross.stroke()
            cross.closePath()
        }
        
        
        
        NSColor.blueColor().setStroke()
        for (x,y) in teamBlue {
            cross = NSBezierPath()
            cross.lineWidth = 3

            cross.moveToPoint(NSMakePoint(x-line, y))
            cross.lineToPoint(NSMakePoint(x+line, y))
            cross.stroke()
            
            cross.moveToPoint(NSMakePoint(x, y-line))
            cross.lineToPoint(NSMakePoint(x, y+line))
            cross.stroke()
            cross.closePath()
        }
        
        
        
    }
    
    
}











