//
//  AppContentView.swift
//  pkg-program8-ios-common
//
//  Created by Wattmonk21 on 30/07/25.
//

import SwiftUI

public struct AppContentView<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel = AppContentViewVM()
    public let content: Content
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
        
    }
    

    public var body: some View {
        AppView(viewModel: viewModel) {
            content
        }
    }
}

private class AppContentViewVM:AppViewModel{
    override init() {
        super.init()
        let _ = FWThemeManager.shared // Intializing default value of FWThemeManager
        
    }
    
    override func onColorSchemeChange(_ scheme: ColorScheme){
        super.onColorSchemeChange(scheme)
        FWThemeManager.shared.updateColorScheme(scheme)
    }
}

//#Preview {
//    AppContentView()
//}
