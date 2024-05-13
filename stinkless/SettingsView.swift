//
//  SettingsView.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 01/05/2024.
//

import SwiftUI
import WidgetKit

struct SettingsView: View {
    
    @Binding var colorScheme: ColorScheme?
    
    @State var maxGoal = getCurrentIntValue(key: maxGoalDefaultKey)
    @State var sleepTime = getCurrentTimeValue(key: sleepTimeDefaultKey)
    
    var body: some View {
        VStack {
            // theme
            HStack {
                Text("Appearance")
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                
                Spacer()
                
                Button {
                    setTheme(themeCode: 0)
                } label: {
                    Text("sys")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                }
                
                Text("|")
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                
                Button {
                    setTheme(themeCode: 1)
                } label: {
                    Text("light")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                }
                
                Text("|")
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                
                Button {
                    setTheme(themeCode: 2)
                } label: {
                    Text("dark")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                }
            }
            
            Divider().foregroundColor(.accentColor)
            
            // max goal
            HStack {
                Text("Max goal")
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                
                Spacer()

                Button {
                    let curr = getCurrentIntValue(key: maxGoalDefaultKey)
                    defaults.set(curr - 1, forKey: maxGoalDefaultKey)
                    maxGoal = curr - 1
                    WidgetCenter.shared.reloadAllTimelines()
                } label: {
                    Image(systemName: "minus.circle.fill", variableValue: 1.00)
                    .symbolRenderingMode(.monochrome)
                    .font(.system(size: 16, weight: .regular))
                }
                .disabled(isDecreasingMaxGoalDisabled())
                
                Text("\(maxGoal)")
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                
                Button {
                    let curr = getCurrentIntValue(key: maxGoalDefaultKey)
                    defaults.set(curr + 1, forKey: maxGoalDefaultKey)
                    maxGoal = curr + 1
                    WidgetCenter.shared.reloadAllTimelines()
                } label: {
                    Image(systemName: "plus.circle.fill", variableValue: 1.00)
                    .symbolRenderingMode(.monochrome)
                    .font(.system(size: 16, weight: .regular))
                }
            }
            
            Divider().foregroundColor(.accentColor)
            
            // sleep time
            HStack {
                Text("Sleep time")
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                
                Spacer()
                
                //Text(sleepTimeFormatter.string(from: sleepTime))
                Button {
                    let curr = getCurrentTimeValue(key: sleepTimeDefaultKey)
                    let newTime = addMinutes(to: curr, minutes: -15)
                    saveCurrentTimeValue(time: newTime, key: sleepTimeDefaultKey)
                    sleepTime = newTime
                    WidgetCenter.shared.reloadAllTimelines()
                } label: {
                    Image(systemName: "minus.circle.fill", variableValue: 1.00)
                    .symbolRenderingMode(.monochrome)
                    .font(.system(size: 16, weight: .regular))
                }
                .disabled(isDecreasingMaxGoalDisabled())
                
                Text(sleepTimeFormatter.string(from: sleepTime))
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                
                Button {
                    let curr = getCurrentTimeValue(key: sleepTimeDefaultKey)
                    let newTime = addMinutes(to: curr, minutes: 15)
                    saveCurrentTimeValue(time: newTime, key: sleepTimeDefaultKey)
                    sleepTime = newTime
                    WidgetCenter.shared.reloadAllTimelines()
                } label: {
                    Image(systemName: "plus.circle.fill", variableValue: 1.00)
                    .symbolRenderingMode(.monochrome)
                    .font(.system(size: 16, weight: .regular))
                }
                
            }
            
            Spacer()
        }
    }
    
    func addMinutes(to time: Date, minutes: Int) -> Date {
        let newTime = calendar.date(byAdding: .minute, value: minutes, to: time)!
        return newTime
    }
    
    func setTheme(themeCode: Int) {
        colorScheme = decodeTheme(themeCode: themeCode)
        defaults.set(themeCode, forKey: colorThemeKey)
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func isDecreasingMaxGoalDisabled() -> Bool {
        if maxGoal == 0 {
            return true
        }
        return false
    }
}

//#Preview {
//    SettingsView()
//}
