//
//  AppView.swift
//  iOS
//
//  Created by Vijay Sachan on 26/08/23.
//

import Foundation
import SwiftUI

struct AppView<Content: View>:View{
    @Environment(\.scenePhase) var scenePhase
    @ViewBuilder let contentView: Content
    private var code:AppViewModel
    init(code:AppViewModel,@ViewBuilder contentView: () -> Content) {
        self.contentView=contentView()
        self.code=code
}
//  var code:MyActionSheetSwiftUIViewCode
    var body: some View {
        contentView.onAppear{
            code.onAppear()
        }
        .onDisappear{
            code.onDisappear()
        }
        .onChange(of: scenePhase) { (phase) in
            code.onChange(scenePhase: phase)
        }
    }
}
struct MyAppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(code: AppViewModel(printTag: "AppView")){
            Text("Hello app view")
        }
    }
}


