//
//  calendar.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 01/05/2024.
//

import Foundation

var calendar = Calendar.current

// Helper function to find the start of the week
func startOfWeek(using date: Date) -> Date? {
    // calendar.firstWeekday = 2 // Sunday = 1, Monday = 2
    return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))
}

// Helper function to find the end of the week
func endOfWeek(using date: Date) -> Date? {
    // calendar.firstWeekday = 2
    if let startOfNextWeek = calendar.date(byAdding: .weekOfYear, value: 1, to: startOfWeek(using: date)!) {
        return startOfNextWeek.addingTimeInterval(-1)
    }
    return nil
}

let durationFormatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.unitsStyle = .abbreviated
    formatter.zeroFormattingBehavior = .dropLeading
    return formatter
}()

let weekIntervalFormatter: DateFormatter = {
    let formatter = DateFormatter()
    //formatter.dateStyle = .short
    //formatter.timeStyle = .none
    formatter.dateFormat = "dd/MM/yy"
    return formatter
}()


let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
    formatter.dateFormat = "dd/MM/yy HH:mm:ss"
    return formatter
}()

let sleepTimeFormatter: DateFormatter = {
    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
    formatter.dateFormat = "HH:mm"
    return formatter
}()
