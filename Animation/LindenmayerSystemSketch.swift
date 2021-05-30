import Foundation
import CanvasGraphics

// NOTE: This is a completely empty sketch; it can be used as a template.
class LindenmayerSystemSketch: NSObject, Sketchable {
    
    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    var canvas: Canvas
    var system: LindenmayerSystem
    var visualizeSystem: Visualizer
    var visualizeSystem2: Visualizer
    var visualizeSystem3: Visualizer
    
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
                                          initialPosition: Point(x: 140, y: 25),
                                          initialHeading: 90,
                                          thickness: 40,
                                          colors: [
                                              "0" : LSColor(hue: 0, saturation: 40, brightness: 50, alpha: 100),
                                          ])
        
        //var system2 = Visualizer(fromJSONFile: "aidan-berry-bush", drawingOn: canvas)
        visualizeSystem2 = Visualizer(fromJSONFile: "aidan-berry-bush", drawingOn: canvas)
        visualizeSystem3 = Visualizer(fromJSONFile: "scott-berry-tree", drawingOn: canvas)
        //var system5 = Visualizer(fromJSONFile: "gordon-basic-branching-tree", drawingOn: canvas)
            
        //render the system
        visualizeSystem.render()
        visualizeSystem2.render()
        visualizeSystem3.render()
        //system4.render()
        //system5.render()
        
        
    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        canvas.fillColor = Color(hue: 132, saturation: 55, brightness: 45, alpha: 100)
        canvas.drawRectangle(at: Point(x: 0, y: 0), width: 500, height: 200)
        
        for color in 0...310{
            canvas.fillColor = Color(hue: 190 + color/9, saturation: 30 + color/5, brightness: 80 - color/10, alpha: 100)
            canvas.drawRectangle(at: Point(x: 0, y: 200 + color), width: 500, height: 1)
        }
        
        for positionX in stride(from: 0, through: 500, by: 9){
            for positionY in stride(from: 0, through: 200, by: 9){
                canvas.lineColor = Color(hue: 139, saturation: 55, brightness: 30, alpha: 100)
                canvas.defaultLineWidth = 3
                canvas.drawLine(from: Point(x: positionX, y: positionY), to: Point(x: positionX, y: positionY + 2))
                canvas.drawLine(from: Point(x: positionX - 3, y: positionY - 3), to: Point(x: positionX - 3, y: positionY + 2))
            }
        }

        let randomValue = Int.random(in: 1...35)
        
        
        let randomPerlinValue = perlinNoise.perlinNoise(x: Double(canvas.frameCount) * step)
        let angle = map(value: randomPerlinValue,
                                 fromLower: 0,
                                 fromUpper: 1.0,
                                 toLower: 0,
                                 toUpper: 35)
        
        visualizeSystem2 = Visualizer(fromJSONFile: "aidan-berry-bush", drawingOn: canvas)
        visualizeSystem2.angleLeft = Degrees(Int(angle))
        visualizeSystem2.angleRight = Degrees(30 - Int(angle))
        visualizeSystem2.colors = ["0" : LSColor(hue: 348, saturation: 90, brightness: 30, alpha: 100),]
        visualizeSystem2.render()
        
        visualizeSystem3 = Visualizer(fromJSONFile: "scott-berry-tree", drawingOn: canvas)
        visualizeSystem3.angleLeft = Degrees(Int(angle))
        visualizeSystem3.angleRight = Degrees(35 - Int(angle))
        visualizeSystem3.colors = ["0" : LSColor(hue: 348, saturation: 80, brightness: 20, alpha: 100),]
        visualizeSystem3.render()
        
        //Visualize the system
        visualizeSystem  = Visualizer(for: system,
                                          on: canvas,
                                          length: 50,
                                          reduction: 1.25,
                                          angleLeft: Degrees(Int(angle)),
                                          angleRight: Degrees(60 - Int(angle)),
                                          initialPosition: Point(x: 140, y: 25),
                                          initialHeading: 90,
                                          thickness: 40,
                                          colors: [
                                              "0" : LSColor(hue: 0, saturation: 20, brightness: 30, alpha: 100),
                                          ])
        visualizeSystem.render()
        
    }
    
}
