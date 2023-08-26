//
//  ColorChanger.swift
//  discoverPage
//
//  Created by Vishal Varma on 7/23/23.
//

import Foundation
import SwiftUI


func colorFromString(_ colorString: String) -> Color {
    switch colorString.lowercased() {
        case "blue":
            return .blue
        case "red":
            return .red
        case "yellow":
            return .yellow
        case "purple":
            return.purple
        case "pink":
            return .pink
        case "green":
            return .green
        case "orange":
            return .orange
        default:
            return .black
    }
}

func colorFromFirstColor(_ colorString: String) -> Color {
    let blueChoices: [String] = ["green"]

    switch colorString.lowercased() {
    case "blue":
        return colorFromString(blueChoices.randomElement() ?? "orange")
    case "green":
        return .orange
    case "red":
        return .orange
    case "yellow":
        return .orange
    case "purple":
        return .pink
    case "pink":
        return .orange
    case "orange":
        return .yellow 
    default:
        return .black
    }
}
