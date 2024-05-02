//
//  ResetButtonView.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 02/05/2024.
//

import SwiftUI

struct ResetButtonView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var itemSize: CGFloat
    
    var body: some View {
        Button(intent: AddItemIntent(
            count: items.count, 
            latestValue: Int(items.count > 0 ? items[0].valueAfter : 0),
            increment: 0,
            reset: true
        )) {
            HStack {
                Text("reset")
                    .font(.system(size: itemSize, weight: .semibold, design: .monospaced))

                Image(systemName: "arrow.clockwise.circle.fill", variableValue: 1.00)
                    .symbolRenderingMode(.monochrome)
                    .font(.system(size: itemSize, weight: .light))
            }
        }
//        Button {
//            addItem(0, true)
//        } label: {
//            HStack {
//                Text("reset")
//                    .font(.system(size: itemSize, weight: .semibold, design: .monospaced))
//                
//                Image(systemName: "arrow.clockwise.circle.fill", variableValue: 1.00)
//                    .symbolRenderingMode(.monochrome)
//                    .font(.system(size: itemSize, weight: .light))
//            }
//        }
    }
    
//    func addItem(_ increment: Int, _ reset: Bool) {
//        withAnimation {
//            addItemPersistence(viewContext: viewContext, items: items, increment: increment, reset: reset)
//        }
//    }
}

//#Preview {
//    ResetButtonView()
//}
