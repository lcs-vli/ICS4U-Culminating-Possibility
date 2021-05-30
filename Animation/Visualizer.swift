
//  LindemayerSystemSketch.swift
//  Animation
//
//  Created by Russell Gordon on 2021-05-04.
//

import Foundation
import CanvasGraphics

// NOTE: This is a completely empty sketch; it can be used as a template.
struct Visualizer: Codable {
    
    // Identify what properties should be encoded to JSON
    enum CodingKeys: CodingKey {
        case system, length, reduction, angleLeft, angleRight, initialX, initialY, initialHeading, thickness, colors
    }
    
    // Canvas to draw on
    var canvas: Canvas?
    
    // Tortoise to draw with
    var turtle: Tortoise?
    
    // MARK: L-system state
    var system: LindenmayerSystem
    
    // MARK: L-system rendering instructions
    
    // The length of the line segments used when drawing the system, at generation 0
    var length: Double
    
    // The length of the line segments used when drawing the system, at the latest generation
    var currentLength: Double
    
    // The factor by which to reduce the initial line segment length after each generation / word re-write
    var reduction: Double
    
    // The angle by which the turtle will turn left or right; in degrees.
    var angleLeft: Degrees
    
    var angleRight: Degrees
    
    // Where the turtle begins drawing on the canvas
    var initialPosition: Point
    
    // The initial direction of the turtle
    var initialHeading: Degrees
    
    // The colors for this L-system
    var colors: [String: LSColor]
    
    var thickness: Double
    
    // Initializer to use when creating a visualization directly from code
    init(for system: LindenmayerSystem,
         on canvas: Canvas,
         length: Double,
         reduction: Double,
         angleLeft: Degrees,
         angleRight: Degrees,
         initialPosition: Point,
         initialHeading: Degrees,
         thickness: Double,
         colors: [String: LSColor] = [
            "0": LSColor.black,
            "1": LSColor.black,
            "2": LSColor.black,
            "3": LSColor.black,
            "4": LSColor.black,
            "5": LSColor.black,
            "6": LSColor.black,
            "7": LSColor.black,
            "8": LSColor.black,
            "9": LSColor.black,
         ]) {
        
        // Set the canvas we will draw on
        self.canvas = canvas
        
        // Create turtle to draw with
        turtle = Tortoise(drawingUpon: canvas)
        
        // MARK: Initialize L-system state
        self.system = system
        
        // MARK: Initialize L-system rendering instructions
        
        // The length of the line segments used when drawing the system, at generation 0
        self.length = length
        
        // The length of the line segments used when drawing the system, at the latest generation
        self.currentLength = length
        
        // The factor by which to reduce the initial line segment length after each generation / word re-write
        self.reduction = reduction
        
        // The angle by which the turtle will turn left or right; in degrees.
        self.angleLeft = angleLeft
        
        self.angleRight = angleRight
        
        // Where the turtle begins drawing on the canvas
        self.initialPosition = initialPosition
        
        // The initial direction of the turtle
        self.initialHeading = initialHeading
        
        self.thickness = thickness
        
        // The colors for this L-system
        self.colors = colors
    }
    
    // Create an instance of this type by decoding from JSON
    init(from decoder: Decoder) throws {
        
        // Use enumeration defined at top of structure to identify values to be decoded
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode each property
        system = try container.decode(LindenmayerSystem.self, forKey: .system)
        length = try container.decode(Double.self, forKey: .length)
        currentLength = length
        reduction = try container.decode(Double.self, forKey: .reduction)
        angleLeft = Degrees(try container.decode(Double.self, forKey: .angleLeft))
        angleRight = Degrees(try container.decode(Double.self, forKey: .angleRight))
        let x = try container.decode(Int.self, forKey: .initialX)
        let y = try container.decode(Int.self, forKey: .initialY)
        initialPosition = Point(x: x, y: y)
        initialHeading = Degrees(try container.decode(Double.self, forKey: .initialHeading))
        thickness = try container.decode(Double.self, forKey: .thickness)
        do {
            try colors = container.decode([String: LSColor].self, forKey: .colors)
        } catch DecodingError.keyNotFound {
            print("key wasn't found for color")
            colors = [
                "0": LSColor.black,
                "1": LSColor.black,
                "2": LSColor.black,
                "3": LSColor.black,
                "4": LSColor.black,
                "5": LSColor.black,
                "6": LSColor.black,
                "7": LSColor.black,
                "8": LSColor.black,
                "9": LSColor.black,
             ]
        }

    }
    
    // Create an instance of this type, loaded from a specific file
    init(fromJSONFile fileName: String, drawingOn canvas: Canvas) {
        
        // Get a pointer to the file
        let url = Bundle.main.url(forResource: fileName, withExtension: "json")!
        
        // Load the contents of the JSON file
        let data = try! Data(contentsOf: url)
        
        // Convert the data from the JSON file into an instance of this type
        self = try! JSONDecoder().decode(Visualizer.self, from: data)

        // Set the canvas that should be drawn upon
        self.canvas = canvas
        self.turtle = Tortoise(drawingUpon: canvas)

    }
        
    // Encode an instance of this type to JSON
    public func encode(to encoder: Encoder) throws {
        
        // Use the enumeration defined at top of structure to identify values to be encoded
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Encode each property
        try container.encode(system, forKey: .system)
        try container.encode(length, forKey: .length)
        try container.encode(reduction, forKey: .reduction)
        try container.encode(angleLeft, forKey: .angleLeft)
        try container.encode(angleRight, forKey: .angleRight)
        try container.encode(initialPosition.x, forKey: .initialX)
        try container.encode(initialPosition.y, forKey: .initialY)
        try container.encode(initialHeading, forKey: .initialHeading)
        try container.encode(thickness, forKey: .thickness)
        try container.encode(colors, forKey: .colors)

    }
    
    // Get the text of the JSON representation of this type
    func printJSONRepresentation() {
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(self)
            print(String(data: data, encoding: .utf8)!)
        } catch {
            print("Unable to encode visualized Lindenmayer system to JSON.")
        }
        
    }
    
    // Visualize the L-system on the canvas
    mutating func render() {
        
        // Regenerate the L-system so this instance is different (rules are re-applied based on random chance)
        system.generate()
        
        // MARK: Prepare for rendering L-system
        self.currentLength = self.length
        // Set the length based on number of generations
        if self.system.generations > 0 {
            for _ in 1...self.system.generations {
                self.currentLength /= self.reduction
            }
        }

        // Move to designated starting position
        canvas?.saveState()
        turtle?.penUp()
        turtle?.setPosition(to: initialPosition)
        turtle?.setHeading(to: initialHeading)
        turtle?.penDown()
        canvas?.restoreState()
        
        // DEBUG:
        print("Now rendering...\n")
        
        // Render the entire system
        for character in system.word {
            
            // Save the state of the canvas (no transformations)
            canvas?.saveState()
            
            // Bring canvas into same orientation and origin position as
            // it was when last character in the word was rendered
            turtle?.restoreStateOnCanvas()
            
            // Render based on this character
            switch character {
            case "\n":
                // Ignore line breaks
                // This allows us to use multi-line strings when defining axioms and rules
                break
            case "0":
                // Placeholder for changing colour
                turtle?.setPenColor(to: colors["0"]?.expectedColor() ?? Color.black)
            case "1":
                // Placeholder for changing colour
                turtle?.setPenColor(to: colors["1"]?.expectedColor() ?? Color.black)
            case "2":
                // Placeholder for changing colour
                turtle?.setPenColor(to: colors["2"]?.expectedColor() ?? Color.black)
            case "3":
                // Placeholder for changing colour
                turtle?.setPenColor(to: colors["3"]?.expectedColor() ?? Color.black)
            case "4":
                // Placeholder for changing colour
                turtle?.setPenColor(to: colors["4"]?.expectedColor() ?? Color.black)
            case "5":
                // Placeholder for changing colour
                turtle?.setPenColor(to: colors["5"]?.expectedColor() ?? Color.black)
            case "6":
                // Placeholder for changing colour
                turtle?.setPenColor(to: colors["6"]?.expectedColor() ?? Color.black)
            case "7":
                // Placeholder for changing colour
                turtle?.setPenColor(to: colors["7"]?.expectedColor() ?? Color.black)
            case "8":
                // Placeholder for changing colour
                turtle?.setPenColor(to: colors["8"]?.expectedColor() ?? Color.black)
            case "9":
                // Placeholder for changing colour
                turtle?.setPenColor(to: colors["9"]?.expectedColor() ?? Color.black)
            case "+":
                // Turn to the left
                turtle?.left(by: angleLeft)
            case "-":
                // Turn to the right
                turtle?.right(by: angleRight)
            case "[":
                thickness = thickness / (1.5 * reduction)
                turtle?.setPenSize(to: Int(thickness))
                // Save position and heading
                turtle?.saveState()
            case "]":
                thickness = thickness * (1.5 * reduction)
                turtle?.setPenSize(to: Int(thickness))
                // Restore position and heading
                turtle?.restoreState()
            case "B":
                // Render a small berry
                canvas?.fillColor = .red
                canvas?.drawEllipse(at: Point(x: 0, y: 0), width: 10, height: 10)
            case "P":
                canvas?.fillColor = Color(hue: 280, saturation: 80, brightness: 90, alpha: 100)
                canvas?.drawEllipse(at: Point(x: 0, y: 0), width: 3, height: 3)
            case "Z":
                canvas?.fillColor = Color(hue: 200, saturation: 100, brightness: 90, alpha: 100)
                canvas?.drawEllipse(at: Point(x: 0, y: 0), width: 3, height: 3)
            case "a", "b", "c", "d", "e":
                // Move the turtle forward without drawing a line
                turtle?.penUp()
                turtle?.forward(steps: Int(round(currentLength)))
                turtle?.penDown()
            case "f":
                turtle?.forward(steps: Int(round(currentLength) / 4))
            default:
                // Any other character means move forward
                turtle?.forward(steps: Int(round(currentLength)))
                break
                
            }
            
            // Restore the state of the canvas (no transformations)
            canvas?.restoreState()
            
        }
        
    }
    
}
