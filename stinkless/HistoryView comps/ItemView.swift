//
//  ItemView.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 01/05/2024.
//

import SwiftUI

struct ItemView: View {
    
    var item: Item
    
    var body: some View {
        VStack {
            HStack {
                Text(item.timestamp!, formatter: itemFormatter)
                    .font(.system(size: 10, weight: .semibold, design: .monospaced))
                
                Spacer()
            }
            
            HStack {
                if !item.reset {
                    Text("(\(item.valueBefore)) + (\(item.increment)) = \(item.valueAfter) / \(item.maxGoal)")
                        .font(.system(size: 14, weight: .semibold, design: .monospaced))
                } else {
                    Text("\(item.valueBefore) → \(item.valueAfter) / \(item.maxGoal)")
                        .font(.system(size: 14, weight: .semibold, design: .monospaced))
                    Text("(reset)")
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                }
                
                Spacer()
            }
            .padding(5)
            
        }
    }
}

//#Preview {
//    ItemView()
//}
