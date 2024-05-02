//
//  AddRemoveItemsView.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 02/05/2024.
//

import SwiftUI

struct AddRemoveItemsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var itemSize: CGFloat
    
    
    var body: some View {
        HStack {
            //Spacer()
            
            // remove
            Button(intent: AddItemIntent(
                count: items.count,
                latestValue: Int(items.count > 0 ? items[0].valueAfter : 0),
                increment: -1,
                reset: false
            )) {
                Image(systemName: "minus.circle", variableValue: 1.00)
                    .symbolRenderingMode(.monochrome)
                    .font(.system(size: itemSize, weight: .light))
            }
            .disabled(isRemovingStinkiesDisabled())
//            Button {
//                addItem(-1, false)
//            } label: {
//                Image(systemName: "minus.circle", variableValue: 1.00)
//                    .symbolRenderingMode(.monochrome)
//                    .font(.system(size: itemSize, weight: .light))
//            }
//            .disabled(isRemovingStinkiesDisabled())
            
            //Spacer()
            
            // add
            Button(intent: AddItemIntent(
                count: items.count,
                latestValue: Int(items.count > 0 ? items[0].valueAfter : 0),
                increment: 1,
                reset: false
            )) {
                Image(systemName: "plus.circle", variableValue: 1.00)
                    .symbolRenderingMode(.monochrome)
                    .font(.system(size: itemSize, weight: .light))
            }
//            Button {
//                addItem(1, false)
//            } label: {
//                Image(systemName: "plus.circle", variableValue: 1.00)
//                    .symbolRenderingMode(.monochrome)
//                    .font(.system(size: itemSize, weight: .light))
//            }
            
            //Spacer()
        }
    }
    
//    func addItem(_ increment: Int, _ reset: Bool) {
//        withAnimation {
//            addItemPersistence(viewContext: viewContext, items: items, increment: increment, reset: reset)
//        }
//    }
    
    
    func isRemovingStinkiesDisabled() -> Bool {
        if items.count == 0 {
            return true
        }
        if items[0].valueAfter == 0 {
            return true
        }
        return false
    }
}

//#Preview {
//    AddRemoveItemsView()
//}
