//
//  AppView.swift
//  iOS
//
//  Created by Vijay Sachan on 26/08/23.
//

import Foundation
import SwiftUI

public struct AppView<Content: View>:HierarchyAwareView{
    public var name: String { viewModel.tagVM }
    public let parentHierarchy: HierarchyTrackable?
    @Environment(\.scenePhase) var scenePhase
    @ViewBuilder let contentView: Content
    private var viewModel:AppViewModel
    public init(viewModel:AppViewModel,@ViewBuilder contentView: () -> Content){
        self.contentView=contentView()
        self.viewModel=viewModel
        self.parentHierarchy=nil
       }

    public var body: some View {
        contentView.onAppear{
            viewModel.onAppear()
        }
        .onDisappear{
            viewModel.onDisappear()
        }
        .onChange(of: scenePhase) { (phase) in
            viewModel.onChange(scenePhase: phase)
        }.logHierarchyPath(self)
    }
}
struct MyAppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(viewModel: AppViewModel(caller: Self.self)){
            Text("Hello app view")
        }
    }
}


