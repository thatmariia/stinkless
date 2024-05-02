//
//  View.swift
//  stinkless
//
//  Created by Mariia Steeghs-Turchina on 02/05/2024.
//

import SwiftUI

extension View {
    func applyColorScheme(_ choice: ColorScheme?) -> some View {
        switch choice {
        case .light:
            return AnyView(self.environment(\.colorScheme, .light))
        case .dark:
            return AnyView(self.environment(\.colorScheme, .dark))
        default:
            return AnyView(self)
        }
    }
}
