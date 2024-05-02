//
//  WeekView.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 01/05/2024.
//

import SwiftUI

struct WeekView: View {
    
    var w: Int
    var currDateWeekStart: Date
    @Binding var itemsWithResets: [Item]
    
    @State var highestEntries = [0, 0, 0, 0, 0, 0, 0]
    
    var body: some View {
        HStack(spacing: 0) {

            ForEach(0..<7) { d in
                
                DayView(w: w, d: d, currDateWeekStart: currDateWeekStart, itemsWithResets: $itemsWithResets, highestValue: $highestEntries[d])
                    .frame(minWidth: 0, maxWidth: .infinity)
                
                
            }
            
        }
    }
}

//#Preview {
//    WeekView()
//}
