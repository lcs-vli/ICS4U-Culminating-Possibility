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
        var system = LindenmayerSystem(axiom: "0XXF",
                                       rules: [
                                        "F": [
                                            Successor(odds: 1, text: "J[-J][++J]"),
                                        ],
                                        "J": [
                                            Successor(odds: 1, text: "XJ[-J][++J]"),
                                            Successor(odds: 1, text: "XJ[--J][+J]"),
                                        ],
                                       ],
                                       generations: 5)
        
        //Visualize the system
        var visualizeSystem  = Visualizer(for: system,
                                          on: canvas,
                                          length: 50,
                                          reduction: 1.25,
                                          angle: 15.5,
                                          initialPosition: Point(x: 250, y: 50),
                                          initialHeading: 90,
                                          radius: 20)
        
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
