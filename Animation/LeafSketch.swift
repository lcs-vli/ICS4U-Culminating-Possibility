//
//  LeafSketch.swift
//  Animation
//
//  Created by Li, Muchen on 2021/5/27.
//

import Foundation
import CanvasGraphics

// NOTE: This is a completely empty sketch; it can be used as a template.
class LeafSketch: NSObject, Sketchable {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    var canvas: Canvas
    
    // This function runs once
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 500)
        
        // Enable faster rendering
        canvas.highPerformance = true
        
        // Create the basic L-system
        var leafSystem = LindenmayerSystem(axiom: "++++++++++++++++++FFFLFFFFFRFFFFL",
                                               rules: [
                                                "L": [
                                                    Successor(odds: 1, text: "0----[++++++F--F--F--F--F--F--F]1[+++++F--F--F--F--F--F]2[++++F--F--F--F--F]3[fFFF]2[----F++F++F++F++F]1[-----F++F++F++F++F++F]0[------F++F++F++F++F++F++F]++++"),
                                                    Successor(odds: 1, text: "0------[++++++F--F--F--F--F--F--F]1[+++++F--F--F--F--F--F]2[++++F--F--F--F--F]3[fFFF]2[----F++F++F++F++F]1[-----F++F++F++F++F++F]0[------F++F++F++F++F++F++F]++++++++++"),
                                                ],
                                                "R": [
                                                    Successor(odds: 1, text: "0++++++[++++++F--F--F--F--F--F--F]1[+++++F--F--F--F--F--F]2[++++F--F--F--F--F]3[fFFF]2[----F++F++F++F++F]1[-----F++F++F++F++F++F]0[------F++F++F++F++F++F++F]------"),
                                                ],
                                               ],
                                             generations: 1)
        
        // Visualize the system
        var visualizedLeaf = Visualizer(for: leafSystem,
                                            on: canvas,
                                            length: 40,
                                            reduction: 3,
                                            angle: 5,
                                            initialPosition: Point(x: 100, y: 100),
                                            initialHeading: 0,
                                            colors: [
                                                "0" : LSColor(hue: 113, saturation: 100, brightness: 40, alpha: 100),
                                                "1" : LSColor(hue: 113, saturation: 100, brightness: 50, alpha: 100),
                                                "2" : LSColor(hue: 113, saturation: 100, brightness: 60, alpha: 100),
                                                "3" : LSColor(hue: 113, saturation: 100, brightness: 70, alpha: 100),
                                            ])

        // Visualize the system
        var visualizedLeaf2 = Visualizer(for: leafSystem,
                                            on: canvas,
                                            length: 40,
                                            reduction: 3,
                                            angle: 5,
                                            initialPosition: Point(x: 250, y: 100),
                                            initialHeading: 0,
                                            colors: [
                                                "0" : LSColor(hue: 113, saturation: 100, brightness: 40, alpha: 100),
                                                "1" : LSColor(hue: 113, saturation: 100, brightness: 50, alpha: 100),
                                                "2" : LSColor(hue: 113, saturation: 100, brightness: 60, alpha: 100),
                                                "3" : LSColor(hue: 113, saturation: 100, brightness: 70, alpha: 100),
                                            ])
        
        // Visualize the system
        var visualizedLeaf3 = Visualizer(for: leafSystem,
                                            on: canvas,
                                            length: 40,
                                            reduction: 3,
                                            angle: 5,
                                            initialPosition: Point(x: 400, y: 100),
                                            initialHeading: 0,
                                            colors: [
                                                "0" : LSColor(hue: 113, saturation: 100, brightness: 40, alpha: 100),
                                                "1" : LSColor(hue: 113, saturation: 100, brightness: 50, alpha: 100),
                                                "2" : LSColor(hue: 113, saturation: 100, brightness: 60, alpha: 100),
                                                "3" : LSColor(hue: 113, saturation: 100, brightness: 70, alpha: 100),
                                            ])
        
        // Render the system
        visualizedLeaf.render()
        visualizedLeaf2.render()
        visualizedLeaf3.render()
        
        
    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        // Nothing is being animated, so nothing needed here
        
    }
    
}
