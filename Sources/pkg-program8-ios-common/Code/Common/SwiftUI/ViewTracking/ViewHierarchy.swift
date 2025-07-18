//
//  ViewHierarchy.swift
//  pkg-program8-ios-common
//
//  Created by Wattmonk21 on 18/07/25.
//

import SwiftUI

// MARK: - Protocol
@MainActor
protocol HierarchyTrackable {
    var parentHierarchy: HierarchyTrackable? { get }
    var name: String { get }
}

extension HierarchyTrackable {
    var fullPath: String {
        (parentHierarchy?.fullPath).map { "\($0) > \(name)" } ?? name
    }
}

// MARK: - View Modifier
struct HierarchyLogger: ViewModifier,FWLoggerDelegate {
    let hierarchy: HierarchyTrackable

    func body(content: Content) -> some View {
        content.onAppear {
            mLog(msg:hierarchy.fullPath)
        }
    }
}

extension View {
    func logHierarchyPath(_ hierarchy: HierarchyTrackable) -> some View {
        modifier(HierarchyLogger(hierarchy: hierarchy))
    }
}

// MARK: - Common View Protocol
protocol HierarchyAwareView: View, HierarchyTrackable {}
extension HierarchyAwareView {
    var name: String { "\(Self.self)" }
}

// MARK: - Example Views

struct RootView: HierarchyAwareView {
    let parentHierarchy: HierarchyTrackable? = nil

    var body: some View {
//        NavigationView {
            VStack {
                NavigationLink("Go to View1") {
                    View1(parentHierarchy: self)
                }
                NavigationLink("Go to View2") {
                    View2(parentHierarchy: self)
                }
            }.logHierarchyPath(self)
//        }
        
    }
}

struct View1: HierarchyAwareView {
    let parentHierarchy: HierarchyTrackable?

    var body: some View {
        VStack {
            Text("This is View1")
            NavigationLink("Go to ChildView") {
                ChildView(parentHierarchy: self)
            }
        }
        .logHierarchyPath(self)
    }
}

struct View2: HierarchyAwareView {
    let parentHierarchy: HierarchyTrackable?

    var body: some View {
        Text("This is View2")
            .logHierarchyPath(self)
    }
}

struct ChildView: HierarchyAwareView {
    let parentHierarchy: HierarchyTrackable?

    var body: some View {
        Text("This is ChildView")
            .logHierarchyPath(self)
    }
}


