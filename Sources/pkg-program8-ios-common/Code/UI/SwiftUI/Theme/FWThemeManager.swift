//
//  FWThemeManager.swift
//  pkg-program8-ios-common
//
//  Created by Wattmonk21 on 30/07/25.
//


import SwiftUI
import Combine
@MainActor
public class FWThemeManager: ObservableObject, FWLoggerDelegate {
    static let shared = FWThemeManager()
    
    @Published public private(set) var colorScheme: ColorScheme!
    private init() {
        let style = UIScreen.main.traitCollection.userInterfaceStyle
        switch style {
        case .dark:
            colorScheme = .dark
            mLog(msg: "Initial color scheme set to Dark")
        case .light, .unspecified:
            colorScheme = .light
            mLog(msg: "Initial color scheme set to Light")
        @unknown default:
            colorScheme = .light
            mLog(msg: "Initial color scheme set to fallback Light (unknown style)")
        }
    }
    
    /// Call this from any view that observes @Environment(\.colorScheme)
    func updateColorScheme(_ scheme: ColorScheme) {
        if colorScheme != scheme {
            colorScheme = scheme
            mLog(msg: "Color scheme updated to \(scheme)")
        }else {
            mLog(msg: "Update ignored, scheme is same as: \(colorScheme!)")
        }
    }

    
    
    var background: Color {
        colorScheme == .dark ? .black : .white
    }
    
    var text: Color {
        colorScheme == .dark ? .white : .black
    }
    
    var primary: Color {
        colorScheme == .dark ? .blue.opacity(0.7) : .blue
    }
}
