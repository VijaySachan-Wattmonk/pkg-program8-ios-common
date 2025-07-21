//
//  AppView.swift
//  iOS
//
//  Created by Vijay Sachan on 26/08/23.
//

import Foundation
import SwiftUI

public struct AppView<Content: View>:View,FWLoggerDelegate{
    @Environment(\.scenePhase) var scenePhase
    @ViewBuilder let contentView: Content
    private var hierarchy: HierarchyTrackable?
    @ObservedObject private var viewModel: AppViewModel
    nonisolated public var tagOfThisView:String="tagOfThisView"
    nonisolated public var tag: String {
            return tagOfThisView
    }
    init(_ hierarchy: HierarchyTrackable?,viewModel: AppViewModel,@ViewBuilder contentView: () -> Content) {
        self.contentView=contentView()
        self.viewModel=viewModel
        self.hierarchy=hierarchy
        viewModel.tagVM=getTag()
        tagOfThisView=getTag()
    }
      private func getTag() -> String {
        return hierarchy?.name ?? N_A
    }
    public var body: some View {
        contentView.onAppear{
            viewModel.onAppear()
            logHierarchy()
        }
        .onDisappear{
            viewModel.onDisappear()
            
        }
        .onChange(of: scenePhase) { (phase) in
            viewModel.onChange(scenePhase: phase)
        }
    }
    private func logHierarchy() {
        mLog(msg: (hierarchy?.fullPath ?? N_A))
    }
}
struct MyAppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(nil, viewModel: AppViewModel()){
            Text("Hello app view")
        }
    }
}
