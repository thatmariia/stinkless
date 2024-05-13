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

func getCurrentTimeValue(key: String) -> Date {
    let dateString = defaults.string(forKey: key) ?? defaultSleepTimeString
    return sleepTimeFormatter.date(from: dateString)!
}

func saveCurrentTimeValue(time: Date, key: String) {
    let timeString = sleepTimeFormatter.string(from: time)
    defaults.setValue(timeString, forKey: key)
}

let maxGoalDefaultKey = "maxGoalDefault"
let sleepTimeDefaultKey = "sleepTimeDefault"

let defaultSleepTimeString = "00:00 AM"

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
