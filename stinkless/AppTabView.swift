//
//  TabView.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 01/05/2024.
//

import SwiftUI

struct AppTabView: View {
    
    @Binding var colorScheme: ColorScheme?
    
    var body: some View {
        TabView {
            
            CurrentStateView()
                .buttonStyle(PlainButtonStyle())
                .tabItem {
                    Label("", systemImage: "button.programmable")
                }
                .padding()
            
            WeeklySummaryView()
                .tabItem {
                    Label("", systemImage: "calendar.badge.exclamationmark")
                }
                .padding()
            
            HistoryView()
                .tabItem {
                    Label("", systemImage: "list.triangle")
                }
                .padding()
            
            SettingsView(colorScheme: $colorScheme)
                .tabItem {
                    Label("", systemImage: "gear")
                }
                .padding()
        }
        
    }
}

//#Preview {
//    TabView()
//}
