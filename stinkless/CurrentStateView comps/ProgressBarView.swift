//
//  ProgressBarView.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 02/05/2024.
//

import SwiftUI
import WidgetKit

struct ProgressBarView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State var duration = "---"
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var progress = 0.0
    
    @Binding var maxGoal: Int
    
    var showTime: Bool
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
            if showTime {
                Text("waiting \(duration) / \(getSuggestedInterval())")
                    .font(.system(size: 13, weight: .semibold, design: .monospaced))
            }
        }
        .onReceive(timer) { _ in
            if items.count > 0 {
                let delta = Date().timeIntervalSince(items[0].timestamp!)
                duration = durationFormatter.string(from: delta) ?? "---"
                let durationSeconds = Double(delta)
                let currProgress = durationSeconds / Double(getSuggestedIntervalSeconds())
                progress = currProgress <= 1.0 ? currProgress : 1.0
            } else {
                duration = "---"
                progress = 0
            }
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
    
    func getSuggestedInterval() -> String {
        let intervalLengthSeconds = getSuggestedIntervalSeconds()
        
        // formatted
        let formattedInterval = durationFormatter.string(from: TimeInterval(intervalLengthSeconds))!
        return formattedInterval
    }
    
    func getCurrValue() -> Int {
        return items.count > 0 ? Int(items[0].valueAfter) : 0
    }
    
    func getSuggestedIntervalSeconds() -> Int {
        // get number of intervals
//        var nrIntervals = (maxGoal - getCurrValue()) + 1
//        if nrIntervals < 1 {
//            nrIntervals = 1
//        }
        var nrIntervals = (maxGoal - getCurrValue())
        if nrIntervals <= 0 {
            nrIntervals = 1
        }
        
        // last recorded time
        var lastTime = Date()
        if items.count > 0 {
            lastTime = items[0].timestamp!
        }
        
        // time at the end of the day
        // let endOfDay = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: Date()))!.addingTimeInterval(-1)
        let endOfDay = getClosestSleepTime().addingTimeInterval(-1)
        
        // get period of time between last recorded time and the end of the day
        let availableSeconds = endOfDay.timeIntervalSince(lastTime)
        
        // length of a single interval
        let intervalLengthSeconds = Int(availableSeconds / Double(nrIntervals))
        
        return intervalLengthSeconds
    }
    
    func getClosestSleepTime() -> Date {
        let sleepTime = getCurrentTimeValue(key: sleepTimeDefaultKey)
        let currentDate = Date()
        
        // date components of now
        let dcCurrentTime = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        // time components of sleep time
        let dcSleepTime = calendar.dateComponents([.hour, .minute, .second], from: sleepTime)
        
        // combine date components
        var combinedComponents = DateComponents()
        combinedComponents.year = dcCurrentTime.year
        combinedComponents.month = dcCurrentTime.month
        combinedComponents.day = dcCurrentTime.day
        combinedComponents.hour = dcSleepTime.hour
        combinedComponents.minute = dcSleepTime.minute
        combinedComponents.second = dcSleepTime.second
        
        // create combined date
        let combinedDate = calendar.date(from: combinedComponents)!

        // if the closest future date is in the past, add a day
        if combinedDate < currentDate {
            return calendar.date(byAdding: .day, value: 1, to: combinedDate)!
        } 
        return combinedDate
        
    }
}

//#Preview {
//    ProgressBarView()
//}
