//
//  TestViewHierarchy.swift
//  pkg-program8-ios-common
//
//  Created by Wattmonk21 on 21/07/25.
//

// MARK: - Example Views
import SwiftUI
public struct TestViewHierarchy: View{
    public init(){}
    public var body: some View {
        AppView(viewModel: AppViewModel(caller: Self.self)){
            VStack {
                NavigationLink("Go to View1") {
                    View1()
                }
                NavigationLink("Go to View2") {
                    View2()
                }
            }
        }
        
    }
}

struct View1:View{
var body: some View {
        AppView(viewModel: AppViewModel(caller: Self.self)){
            VStack {
                Text("This is View1")
                NavigationLink("Go to ChildView") {
                    ChildView()
                }
            }
        }
    }
}

struct View2:View{

    var body: some View {
        AppView(viewModel: AppViewModel(caller: Self.self)){
            Text("This is View2")
                
        }
    }
}

struct ChildView:View{

    var body: some View {
        AppView(viewModel: AppViewModel(caller: Self.self)){
            Text("This is ChildView")
        }
            
    }
}
