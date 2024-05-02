//
//  WeeklySummaryView.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 01/05/2024.
//

import SwiftUI

struct WeeklySummaryView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    let currDateWeekEnd = endOfWeek(using: Date())
    let currDateWeekStart = startOfWeek(using: Date())
    @State var nrOfWeeks: Int = 0
    
    @State var itemsWithResets: [Item] = []
    
    var body: some View {
        if items.count == 0 {
            VStack {
                HStack {
                    Text("Weekly summary")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    
                    Spacer()
                }
                Spacer()
            }
        } else {
            ScrollView(.vertical) {
                ForEach(0..<nrOfWeeks, id: \.self) { w in
                    
                    VStack {
                        
                        HStack {
                            Text("week \(getWeekIntervalStart(weeksToSubtract: w)) - \(getWeekIntervalEnd(weeksToSubtract: w))")
                                .font(.system(size: 10, weight: .semibold, design: .monospaced))
                            
                            Spacer()
                        }
                        
                        WeekView(w: w, currDateWeekStart: currDateWeekStart!, itemsWithResets: $itemsWithResets)
                        
                        //if w < nrOfWeeks - 1 {
                        Divider().foregroundColor(.accentColor)
                        //}
                    }
                    
                }
            }
            .onAppear {
                computeNrRecordedWeeks()
                computeItemsWithResets()
            }
        }
    }
    
    func getWeekIntervalEnd(weeksToSubtract: Int) -> String {
        // subtract weeks
        let startWeekDate = calendar.date(byAdding: .weekOfYear, value: -weeksToSubtract, to: currDateWeekStart!)
        let endWeekDate = calendar.date(byAdding: .weekOfYear, value: 1, to: startWeekDate!)!.addingTimeInterval(-1)
        
        return weekIntervalFormatter.string(from: endWeekDate)
    }
    
    func getWeekIntervalStart(weeksToSubtract: Int) -> String {
        // subtract weeks
        let startWeekDate = calendar.date(byAdding: .weekOfYear, value: -weeksToSubtract, to: currDateWeekStart!)
        
        return weekIntervalFormatter.string(from: startWeekDate!)
    }
    
    func computeNrRecordedWeeks() {
        let calendar = Calendar.current
        
        var firstDate = Date()
        if items.count > 0 {
            firstDate = items.last!.timestamp!
        }
        
        let firstDateWeekStart = startOfWeek(using: firstDate)!
        let weeksBetween = calendar.dateComponents([.weekOfYear], from: firstDateWeekStart, to: currDateWeekEnd!).weekOfYear!
        
        nrOfWeeks = weeksBetween + 1
    }
    
    func computeItemsWithResets() {
        itemsWithResets = items.filter { $0.reset == true }
    }
}

#Preview {
    WeeklySummaryView()
}
