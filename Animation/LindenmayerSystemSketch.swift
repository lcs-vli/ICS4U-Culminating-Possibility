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
        var system = LindenmayerSystem(axiom: "0XF",
                                       rules: [
                                        "F": [
                                            Successor(odds: 1, text: "0F[---J][--J][-J][+J]"),
                                        ],
                                        "J": [
                                            Successor(odds: 1, text: "1K[+XK]XK[-XK]"),
                                            Successor(odds: 5, text: "1K[-XK]XK[+XK][XK]"),
                                        ],
                                        "K": [
                                            Successor(odds: 1, text: "2J[+XJ]XJ[-XJ]"),
                                            Successor(odds: 5, text: "2J[-XJ]XJ[+XJ][XJ]"),
                                        ]
                                       ],
                                       generations: 4)
        
        //Visualize the system
        var visualizeSystem  = Visualizer(for: system,
                                          on: canvas,
                                          length: 50,
                                          reduction: 1.25,
                                          angle: 15.5,
                                          initialPosition: Point(x: 250, y: 150),
                                          initialHeading: 90)
        
        //var system2 = Visualizer(fromJSONFile: "aidan-berry-bush", drawingOn: canvas)
        //var system3 = Visualizer(fromJSONFile: "scott-berry-tree", drawingOn: canvas)
        //var system4 = Visualizer(fromJSONFile: "sihan-tree", drawingOn: canvas)
        //var system5 = Visualizer(fromJSONFile: "gordon-basic-branching-tree", drawingOn: canvas)
            
        //render the system
        visualizeSystem.render()
        //system2.render()
        //system3.render()
        //system4.render()
        //system5.render()
        
        
    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        // Nothing is being animated, so nothing needed here
        
    }
    
}
