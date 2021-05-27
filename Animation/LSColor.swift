//
//  LSColor.swift
//  Animation
//
//  Created by Li, Muchen on 2021/5/27.
//

import Foundation
import CanvasGraphics

class LSColor: Codable {
    
    // Identify what properties should be encoded to JSON
    enum CodingKeys: CodingKey {
        case hue, saturation, brightness, alpha
    }

    var hue: Int
    var saturation: Int
    var brightness: Int
    var alpha: Int
    
    // Static properties for convenience for basic colors
    public static let black: LSColor = LSColor(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    public static let white: LSColor = LSColor(hue: 0, saturation: 0, brightness: 100, alpha: 100)
    public static let red: LSColor = LSColor(hue: 0, saturation: 80, brightness: 90, alpha: 100)
    public static let orange: LSColor = LSColor(hue: 30, saturation: 80, brightness: 90, alpha: 100)
    public static let yellow: LSColor = LSColor(hue: 60, saturation: 80, brightness: 90, alpha: 100)
    public static let green: LSColor = LSColor(hue: 120, saturation: 80, brightness: 90, alpha: 100)
    public static let blue: LSColor = LSColor(hue: 240, saturation: 80, brightness: 90, alpha: 100)
    public static let purple: LSColor = LSColor(hue: 270, saturation: 80, brightness: 90, alpha: 100)
    
    init(hue: Int, saturation: Int, brightness: Int, alpha: Int) {
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
        self.alpha = alpha
    }
    
    public required init(from decoder: Decoder) throws {
        // Use the enumeration defined at top of structure to identify values to be decoded
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode each property
        hue = try container.decode(Int.self, forKey: .hue)
        saturation = try container.decode(Int.self, forKey: .saturation)
        brightness = try container.decode(Int.self, forKey: .brightness)
        alpha = try container.decode(Int.self, forKey: .alpha)
    }
    
    public func encode(to encoder: Encoder) throws {
        
        // Use the enumeration defined at top of structure to identify values to be encoded
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Encode each property
        try container.encode(hue, forKey: .hue)
        try container.encode(saturation, forKey: .saturation)
        try container.encode(brightness, forKey: .brightness)
        try container.encode(alpha, forKey: .alpha)

    }
    
    // Return an instance of the actual color type required by the Canvas and Tortoise classes
    func expectedColor() -> Color {
        return Color(hue: self.hue, saturation: self.saturation, brightness: self.brightness, alpha: self.alpha)
    }
    
}
