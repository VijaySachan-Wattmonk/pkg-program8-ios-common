//
//  AppViewModel.swift
//  iOS
//
//  Created by Vijay Sachan on 26/08/23.
//

import Foundation
import SwiftUI
public class AppViewModel:ObservableObject,FWLoggerDelegate{
    public var tag:String { "AppViewModel > "+tagVM }
    let tagVM:String
    private init(){
        tagVM="VM tag not set"
    }
    
    public init<T>(caller: T.Type) {
            self.tagVM = String(describing: caller)
        }
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
