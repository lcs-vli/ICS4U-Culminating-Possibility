import Foundation
import CanvasGraphics

// NOTE: This is a completely empty sketch; it can be used as a template.
class LindenmayerSystemSketch: NSObject, Sketchable {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    var canvas: Canvas
    var system: LindenmayerSystem
    var visualizeSystem: Visualizer
    
    var perlinNoise = PerlinGenerator()
    var step = 0.03
    
    // This function runs once
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 500)
        
        // Enable faster rendering
        canvas.highPerformance = true
        
        //let randomValue = Int.random(in: 1...45)
        //let randomPerlinValue = perlinNoise.perlinNoise(x: Double(canvas.frameCount) * step)
        //let angle = map(value: randomPerlinValue,
                                 //fromLower: 0,
                                 //fromUpper: 1.0,
                                 //toLower: 0,
                                 //toUpper: 45)
        
        //define the L system
        system = LindenmayerSystem(axiom: "0XXF",
                                       rules: [
                                        "F": [
                                            Successor(odds: 1, text: "J[-J][+J]"),
                                        ],
                                        "J": [
                                            Successor(odds: 1, text: "XJ[-JB][+JB]"),
                                        ],
                                       ],
                                       generations: 5)
        
        //Visualize the system
        visualizeSystem  = Visualizer(for: system,
                                          on: canvas,
                                          length: 50,
                                          reduction: 1.25,
                                          angleLeft: 45,
                                          angleRight: 45,
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
        
        let randomValue = Int.random(in: 1...45)
        
        canvas.fillColor = Color.white
        canvas.drawRectangle(at: Point(x: 0, y: 0), width: 500, height: 500)
        
        let randomPerlinValue = perlinNoise.perlinNoise(x: Double(canvas.frameCount) * step)
        let angle = map(value: randomPerlinValue,
                                 fromLower: 0,
                                 fromUpper: 1.0,
                                 toLower: 0,
                                 toUpper: 45)
        //Visualize the system
        visualizeSystem  = Visualizer(for: system,
                                          on: canvas,
                                          length: 50,
                                          reduction: 1.25,
                                          angleLeft: Degrees(Int(angle)),
                                          angleRight: Degrees(90 - Int(angle)),
                                          initialPosition: Point(x: 250, y: 50),
                                          initialHeading: 90,
                                          radius: 30)
        visualizeSystem.render()
        
    }
    
}
