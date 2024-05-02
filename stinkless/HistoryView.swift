//
//  HistoryView.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 01/05/2024.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    var body: some View {
        
        if items.count == 0 {
            VStack {
                HStack {
                    Text("History of entries")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    
                    Spacer()
                }
                Spacer()
            }
        } else {
            VStack {
                HStack {
                    
                    Spacer()
                    
                    // export csv
                    ShareLink(item:exportCSV()) {
                        Image(systemName: "square.and.arrow.up.fill", variableValue: 1.00)
                            .symbolRenderingMode(.monochrome)
                            .font(.system(size: 12, weight: .light))
                        
                        Text("csv")
                            .font(.system(size: 10, weight: .semibold, design: .monospaced))
                    }
                    
                    Text("|")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    
                    // remove all button
                    Button {
                        deleteAllItems()
                    } label: {
                        HStack {
                            
                            Image(systemName: "trash.circle.fill", variableValue: 1.00)
                                .symbolRenderingMode(.monochrome)
                                .font(.system(size: 12, weight: .light))
                            
                            Text("all")
                                .font(.system(size: 10, weight: .semibold, design: .monospaced))
                        }
                    }
                    .disabled(isRemoveAllDisabled())
                }
                
                // history
                //            ScrollView(.vertical) {
                //
                //                ForEach(items) { item in
                //
                //                    VStack {
                //                        ItemView(item: item)
                //
                //                        if item.timestamp! != items.last?.timestamp {
                //                            Divider().foregroundStyle(.accent)
                //                        }
                //                    }
                //                }
                //            }
                

                
                // history
                List {
                    
                    ForEach(items) { item in
                        ItemView(item: item)
                            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                            .listRowInsets(EdgeInsets())
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                if item.timestamp == items[0].timestamp {
                                    Button {
                                        deleteItem(item: item)
                                    } label: {
                                        Label("", systemImage: "trash.circle")
                                    }
                                }
                            }
                    }
                    //.onDelete(perform: deleteItems)
                }.listStyle(.plain)
            }
        }
    }

    
    func exportCSV() -> URL {
        var fileURL: URL!
        
        // heading of CSV file.
        let heading = "timestamp, value before, increment, value after, max goal, reset\n"
        
        // file rows
        let rows = items.map {
            "\($0.timestamp ?? Date(timeIntervalSince1970: 0)), \($0.valueBefore), \($0.increment), \($0.valueAfter), \($0.maxGoal), \($0.reset)"
        }
        
        // rows to string data
        let stringData = heading + rows.joined(separator: "\n")
        
        do {
                    
            let path = try FileManager.default.url(
                for: .documentDirectory,
                in: .allDomainsMask,
                appropriateFor: nil,
                create: false
            )
            
            fileURL = path.appendingPathComponent("stinkless-data.csv")
            
            // append string data to file
            try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
            print(fileURL!)
            
        } catch {
            print("error generating csv file")
        }
        return fileURL
    }
    
    func isRemoveAllDisabled() -> Bool {
        if items.count == 0 {
            return true
        }
        return false
    }
    
    func deleteItem(item: Item) {
        viewContext.delete(item)
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func deleteAllItems() {

        for item in items {
            viewContext.delete(item)
        }

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
}

//#Preview {
//    HistoryView()
//}
