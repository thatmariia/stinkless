//
//  DayView.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 01/05/2024.
//

import SwiftUI

struct DayView: View {
    
    var w: Int
    var d: Int
    var currDateWeekStart: Date
    @Binding var itemsWithResets: [Item]
    
    @Binding var highestValue: Int
    
    var body: some View {
        Text(highestValue != -1 ? String(highestValue) : "⌀")
            .font(.system(size: 16, weight: .semibold, design: .monospaced))
            .padding(5)
            .onAppear {
                getHighestEntryOfDay(weeksToSubtract: w, daysToAdd: d)
            }
    }
    
    func getHighestEntryOfDay(weeksToSubtract: Int, daysToAdd: Int) {
        // subtract weeks
        let dateAfterSubtractingWeeks = calendar.date(byAdding: .weekOfYear, value: -weeksToSubtract, to: currDateWeekStart)
        // add days
        let finalDate = calendar.date(byAdding: .day, value: daysToAdd, to: dateAfterSubtractingWeeks!)!
        
        let resetsOnTheDate = itemsWithResets.filter {
            calendar.isDate($0.timestamp!, equalTo: finalDate, toGranularity: .day)
        }
        
        if resetsOnTheDate.count == 0 {
            highestValue = -1
            return
        }
        
        let itemWithMaxValueBeforeReset = resetsOnTheDate.max {
            $0.valueBefore < $1.valueBefore
        }
        
        highestValue = Int(itemWithMaxValueBeforeReset!.valueBefore)
    }
}

//#Preview {
//    DayView()
//}
