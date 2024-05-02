//
//  Defaults.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 01/05/2024.
//

import Foundation
import SwiftUI

let defaults = UserDefaults(suiteName: "group.stinkless")!//UserDefaults.standard

func getCurrentIntValue(key: String) -> Int {
    return defaults.object(forKey: key) as? Int ?? 0
}

let maxGoalDefaultKey = "maxGoalDefault"

let colorThemeKey = "colorTheme"

func decodeTheme(themeCode: Int) -> ColorScheme? {
    switch themeCode {
    case 1:
        return ColorScheme(UIUserInterfaceStyle.light)
    case 2:
        return ColorScheme(UIUserInterfaceStyle.dark)
    default:
        return ColorScheme(UIUserInterfaceStyle.unspecified)
    }
}

func getColorScheme() -> ColorScheme? {
    let themeCode = defaults.integer(forKey: colorThemeKey)
    return decodeTheme(themeCode: themeCode)
}
