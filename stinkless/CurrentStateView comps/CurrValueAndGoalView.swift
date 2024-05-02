//
//  CurrValueAndGoalView.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 02/05/2024.
//

import SwiftUI

struct CurrValueAndGoalView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @Binding var maxGoal: Int
    
    var itemSize: CGFloat
    
    var body: some View {
        HStack {
            // current value
            Text("\(getCurrValue())")
                .font(.system(size: itemSize, weight: .bold, design: .monospaced))
            
            Text("/")
                .font(.system(size: itemSize, weight: .regular, design: .monospaced))
            
            Text("\(maxGoal)")
                .font(.system(size: itemSize, weight: .bold, design: .monospaced))
        }
    }
    
    func getCurrValue() -> Int {
        return items.count > 0 ? Int(items[0].valueAfter) : 0
    }
}

//#Preview {
//    CurrValueAndGoalView()
//}
