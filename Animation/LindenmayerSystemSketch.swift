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
    var step = 0.02
    
    // This function runs once
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 500)
        
        // Enable faster rendering
        canvas.highPerformance = true
        
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
                                          thickness: 20,
                                          colors: [
                                              "0" : LSColor(hue: 0, saturation: 40, brightness: 50, alpha: 100),
                                          ])
        
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
        
        canvas.fillColor = Color(hue: 132, saturation: 50, brightness: 50, alpha: 100)
        canvas.drawRectangle(at: Point(x: 0, y: 0), width: 500, height: 200)
        
        for color in 0...310{
            canvas.fillColor = Color(hue: 190 + color/4, saturation: 30 + color/8, brightness: 80 - color/10, alpha: 100)
            canvas.drawRectangle(at: Point(x: 0, y: 200 + color), width: 500, height: 1)
        }
        
        let randomValue = Int.random(in: 1...35)
        
        
        let randomPerlinValue = perlinNoise.perlinNoise(x: Double(canvas.frameCount) * step)
        let angle = map(value: randomPerlinValue,
                                 fromLower: 0,
                                 fromUpper: 1.0,
                                 toLower: 0,
                                 toUpper: 35)
        //Visualize the system
        visualizeSystem  = Visualizer(for: system,
                                          on: canvas,
                                          length: 50,
                                          reduction: 1.25,
                                          angleLeft: Degrees(Int(angle)),
                                          angleRight: Degrees(60 - Int(angle)),
                                          initialPosition: Point(x: 160, y: 25),
                                          initialHeading: 90,
                                          thickness: 30,
                                          colors: [
                                              "0" : LSColor(hue: 0, saturation: 20, brightness: 30, alpha: 100),
                                          ])
        visualizeSystem.render()
        
    }
    
}
