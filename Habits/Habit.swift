//
//  Habit.swift
//  Habits
//
//  Created by Gleb Osotov on 4/21/22.
//

import Foundation
import UIKit

struct Habit: Codable {
    let name: String
    let category: Category
    let info: String
}

struct Category: Codable {
    let name: String
    let color: Color
}

struct Color: Codable {
    let hue: Double
    let saturation: Double
    let brightness: Double
    
    enum CodingKeys: String, CodingKey {
        case hue = "h"
        case saturation = "s"
        case brightness = "b"
    }
}

extension Habit: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        lhs.name == rhs.name
    }
}

extension Category: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.name == rhs.name
    }
}

extension Habit: Comparable {
    static func < (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.name < rhs.name
    }
}

extension Color {
    var uiColor: UIColor {
        return UIColor(hue: CGFloat(hue), saturation: CGFloat(saturation), brightness: CGFloat(brightness), alpha: 1)
    }
}

extension Color: Hashable { }
