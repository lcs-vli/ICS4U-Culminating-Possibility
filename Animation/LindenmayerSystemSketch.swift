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
    //var visualizeSystem4: Visualizer
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
        
        //Visualize the systems
        visualizeSystem  = Visualizer(for: system,
                                          on: canvas,
                                          length: 50,
                                          reduction: 1.25,
                                          angleLeft: 45,
                                          angleRight: 45,
                                          initialPosition: Point(x: 140, y: 25),
                                          initialHeading: 90,
                                          thickness: 30,
                                          colors: [
                                              "0" : LSColor(hue: 0, saturation: 40, brightness: 50, alpha: 100),
                                          ])

        visualizeSystem2 = Visualizer(fromJSONFile: "aidan-berry-bush", drawingOn: canvas)
        visualizeSystem3 = Visualizer(fromJSONFile: "scott-berry-tree", drawingOn: canvas)
        //visualizeSystem4 = Visualizer(fromJSONFile: "Fernanda-Plan2", drawingOn: canvas)
            
        //render the systems
        visualizeSystem.render()
        visualizeSystem2.render()
        visualizeSystem3.render()
        //visualizeSystem4.render()
        
        
    }
    
    // This function runs repeatedly, forever, to create the animated effect
    func draw() {
        
        //grass at the bottom
        canvas.fillColor = Color(hue: 132, saturation: 55, brightness: 45, alpha: 100)
        canvas.drawRectangle(at: Point(x: 0, y: 0), width: 500, height: 200)
        
        //darker grass
        for positionX in stride(from: 0, through: 500, by: 9){
            for positionY in stride(from: 0, through: 200, by: 9){
                canvas.lineColor = Color(hue: 139, saturation: 55, brightness: 30, alpha: 100)
                canvas.defaultLineWidth = 3
                canvas.drawLine(from: Point(x: positionX, y: positionY), to: Point(x: positionX, y: positionY + 2))
                canvas.drawLine(from: Point(x: positionX - 3, y: positionY - 3), to: Point(x: positionX - 3, y: positionY + 2))
            }
        }
        
        //sky with a gradient color
        for color in 0...310{
            canvas.fillColor = Color(hue: 190 + color/9, saturation: 30 + color/5, brightness: 80 - color/10, alpha: 100)
            canvas.drawRectangle(at: Point(x: 0, y: 200 + color), width: 500, height: 1)
        }

        //create a random Perlin value with a range from 0 degrees to 35 degrees
        let randomValue = Int.random(in: 1...35)
        let randomPerlinValue = perlinNoise.perlinNoise(x: Double(canvas.frameCount) * step)
        let angle = map(value: randomPerlinValue,
                                 fromLower: 0,
                                 fromUpper: 1.0,
                                 toLower: 0,
                                 toUpper: 35)
        
        //render visualizeSystem2
        visualizeSystem2 = Visualizer(fromJSONFile: "aidan-berry-bush", drawingOn: canvas)
        visualizeSystem2.angleLeft = Degrees(Int(angle))
        visualizeSystem2.angleRight = Degrees(30 - Int(angle))
        visualizeSystem2.colors = ["0" : LSColor(hue: 348, saturation: 90, brightness: 30, alpha: 100),]
        visualizeSystem2.render()
        
        //render visualizeSystem3
        visualizeSystem3 = Visualizer(fromJSONFile: "scott-berry-tree", drawingOn: canvas)
        visualizeSystem3.angleLeft = Degrees(Int(angle))
        visualizeSystem3.angleRight = Degrees(35 - Int(angle))
        visualizeSystem3.colors = ["0" : LSColor(hue: 348, saturation: 80, brightness: 20, alpha: 100),]
        visualizeSystem3.render()
        
//        render visualizeSystem4
//        visualizeSystem4 = Visualizer(fromJSONFile: "Fernanda-Plan2", drawingOn: canvas)
//        visualizeSystem4.angleLeft = Degrees(Int(angle))
//        visualizeSystem4.angleRight = Degrees(35 - Int(angle))
//        visualizeSystem4.render()
        
        //Visualize the system
        visualizeSystem  = Visualizer(for: system,
                                          on: canvas,
                                          length: 50,
                                          reduction: 1.25,
                                          angleLeft: Degrees(Int(angle)),
                                          angleRight: Degrees(60 - Int(angle)),
                                          initialPosition: Point(x: 140, y: 25),
                                          initialHeading: 90,
                                          thickness: 30,
                                          colors: [
                                              "0" : LSColor(hue: 0, saturation: 20, brightness: 30, alpha: 100),
                                          ])
        visualizeSystem.render()
        
        // add to the trunk of my tree
        canvas.fillColor = Color(hue: 0, saturation: 20, brightness: 30, alpha: 100)
        canvas.drawCustomShape(with: [Point(x: 120, y: 19), Point(x: 130, y: 160), Point(x: 150, y: 160), Point(x: 160, y: 19)])
        //canvas.drawCustomShape(with: [Point(x: 410, y: 20), Point(x: 420, y: 160), Point(x: 440, y: 160), Point(x: 450, y: 20)])
    }
    
}
