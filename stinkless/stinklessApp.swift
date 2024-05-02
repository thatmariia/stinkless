//
//  stinklessApp.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 01/05/2024.
//

import SwiftUI

@main
struct stinklessApp: App {
    let persistenceController = PersistenceController.shared
    
    @State var colorScheme: ColorScheme? = getColorScheme()

    var body: some Scene {
        WindowGroup {
            ContentView(colorScheme: $colorScheme)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .defaultAppStorage(UserDefaults(suiteName: "group.stinkless")!)
                .preferredColorScheme(colorScheme)
                .foregroundStyle(.primary)
                .tint(.accent)
        }
    }
}
