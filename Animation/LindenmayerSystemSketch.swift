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
        var system = LindenmayerSystem(axiom: "XF",
                                       rules: [
                                        "F": [
                                            Successor(odds: 1, text: "F[---J][--J][-J][+J]"),
                                        ],
                                        "J": [
                                            Successor(odds: 1, text: "J[+XJ]XJ[-XJ]"),
                                            Successor(odds: 5, text: "J[-XJ]XJ[+XJ][XJ]"),
                                        ]
                                       ],
                                       generations: 5)
        
        //Visualize the system
        var visualizeSystem  = Visualizer(for: system,
                                          on: canvas,
                                          length: 16,
                                          reduction: 1.25,
                                          angle: 15.5,
                                          initialPosition: Point(x: 150, y: 80),
                                          initialHeading: 90)
        
        //render the system
        visualizeSystem.render()
        
        visualizeSystem.printJSONRepresentation()
    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        // Nothing is being animated, so nothing needed here
        
    }
    
}
