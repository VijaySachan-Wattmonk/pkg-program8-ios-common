//
//  AppViewModel.swift
//  iOS
//
//  Created by Vijay Sachan on 26/08/23.
//

import Foundation
import SwiftUI

public class AppViewModel: ObservableObject, FWLoggerDelegate {
    private var isWorking = false
    public var tag: String { "\(AppViewModel.self) > " + tagVM }
    var tagVM: String = "Not set"

    deinit { onDeinit() }

    func onAppear() {
        performLifecycleEvent("onAppear") { self.startWork() }
    }

    func onDisappear() {
        performLifecycleEvent("onDisappear") { self.endWork() }
    }

    func active() {
        performLifecycleEvent("active") { self.startWork() }
    }

    func background() {
        performLifecycleEvent("background") { self.endWork() }
    }

    func inactive() {
        performLifecycleEvent("inactive")
    }

    func onDeinit() {
        performLifecycleEvent("onDeinit") {}
    }

    func onChange(scenePhase: ScenePhase) {
        switch scenePhase {
            case .active: active()
            case .background: background()
            case .inactive: inactive()
            @unknown default: mLog(msg: "ScenePhase: unexpected state")
        }
    }

    private func startWork() {
        guard !isWorking else { return }
        isWorking = true; mLog(msg: "startWork"); onStartWork()
    }

    private func endWork() {
        guard isWorking else { return }
        isWorking = false; mLog(msg: "endWork"); onEndWork()
    }

    func onStartWork() {
        // Override in subclass for custom start logic
    }

    func onEndWork() {
        // Override in subclass for custom end logic
    }

    func performLifecycleEvent(_ eventName: String, action: (() -> Void)? = nil) {
        mLog(msg: eventName)
        action?()
    }
    private func todo() {
        let _="""
            1. Add method onDismiss which will be invoked, When View is dismissed manually or sliding right
            """
    }
}
