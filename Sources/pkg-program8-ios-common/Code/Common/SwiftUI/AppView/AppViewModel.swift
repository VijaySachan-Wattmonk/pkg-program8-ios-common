//
//  AppViewModel.swift
//  iOS
//
//  Created by Vijay Sachan on 26/08/23.
//

import Foundation
import SwiftUI
public class AppViewModel:ObservableObject{
    private let TAG:String
    private init(){
        TAG="TAG"
    }
    init(printTag:String){
        
        TAG=printTag
    }
    /**
     This method invokes just before the view appears
     */
    func onAppear(){
        mLog("onAppear")
    }
    /**
     This method invokes after the view disappears.
     */
    func onDisappear(){
        mLog("onDisappear")
    }
    func active(){
        mLog("active")
    }
    func background(){
        mLog("background")
    }
    func inactive(){
        mLog("inactive")
    }
    func onChange(scenePhase:ScenePhase){
        switch scenePhase {
        case .active: active();break
        case .background: background();break
        case .inactive: inactive();break
        @unknown default: mLog("ScenePhase: unexpected state")
        }
    }
    
    func mLog(_ msg:String){
        print(TAG+" : "+msg)
    }
}
