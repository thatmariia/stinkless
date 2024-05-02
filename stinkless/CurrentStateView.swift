//
//  CurrentStateView.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 01/05/2024.
//

import SwiftUI

struct CurrentStateView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State var maxGoal = getCurrentIntValue(key: maxGoalDefaultKey)
    
    var body: some View {
        VStack {
            Spacer()
            
            // curr progress
            CurrValueAndGoalView(maxGoal: $maxGoal, itemSize: 50)
            
            // buttons to add / remove
            AddRemoveItemsView(itemSize: 100)
            
            // time progress bar
            ProgressBarView(maxGoal: $maxGoal, showTime: true)

            Spacer()
            
            // reset button
            ResetButtonView(itemSize: 16)
            
            Spacer().frame(height: 40)
        }
        .onAppear {
            maxGoal = getCurrentIntValue(key: maxGoalDefaultKey)
        }
    }
}

#Preview {
    CurrentStateView()
}
