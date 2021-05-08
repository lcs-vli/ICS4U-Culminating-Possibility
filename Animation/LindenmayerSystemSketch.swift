import Foundation
import CanvasGraphics

// NOTE: This is a completely empty sketch; it can be used as a template.
class LindenmayerSystemSketch: NSObject, Sketchable {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    var canvas: Canvas
    
    // This function runs once
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 500)
        
        // Enable faster rendering
        canvas.highPerformance = true
        
        
        //define the L system
        var system = LindenmayerSystem(axiom: "XXF",
                                       rules: [
                                        "F": [
                                            Successor(odds: 1, text: "F+[J]F-[J]"),
                                            Successor(odds: 4, text: "F-[J]F+[J]"),
                                        ],
                                        "J": [
                                            Successor(odds: 1, text: "XXXF+[J]F-[J]"),
                                            Successor(odds: 10, text: "XXXF-[J]F+[J]"),
                                        ]
                                       ],
                                       generations: 4)
        
        //Visualize the system
        var visualizeSystem  = Visualizer(for: system,
                                          on: canvas,
                                          length: 20,
                                          reduction: 1.15,
                                          angle: 18.5,
                                          initialPosition: Point(x: 250, y: 100),
                                          initialHeading: 90)
        
        //visualizeSystem  = Visualizer(fromJSONFile: "scott-berry-tree", drawingOn: canvas)
        
        //render the system
        visualizeSystem.render()
    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        // Nothing is being animated, so nothing needed here
        
    }
    
}
