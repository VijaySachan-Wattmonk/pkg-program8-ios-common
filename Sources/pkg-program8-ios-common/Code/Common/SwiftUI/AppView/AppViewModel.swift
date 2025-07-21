//
//  AppViewModel.swift
//  iOS
//
//  Created by Vijay Sachan on 26/08/23.
//

import Foundation
import SwiftUI
public class AppViewModel:ObservableObject,FWLoggerDelegate{
    public var tag: String {"\(AppViewModel.self) > "+tagVM}
    var tagVM:String="Not set"
//    private init(){
//        tagVM="tagVM not set"
//    }
//    init<T>(caller:T.Type){
//        tagVM="\(String(describing: caller))"
//       
//    }
    /**
     This method invokes just before the view appears
     */
    func onAppear(){
        mLog(msg:"onAppear")
    }
    /**
     This method invokes after the view disappears.
     */
    func onDisappear(){
        mLog(msg:"onDisappear")
    }
    func active(){
        mLog(msg:"active")
    }
    func background(){
        mLog(msg:"background")
    }
    func inactive(){
        mLog(msg:"inactive")
    }
    func onChange(scenePhase:ScenePhase){
        switch scenePhase {
        case .active: active();break
        case .background: background();break
        case .inactive: inactive();break
        @unknown default: mLog(msg:"ScenePhase: unexpected state")
        }
    }
}
