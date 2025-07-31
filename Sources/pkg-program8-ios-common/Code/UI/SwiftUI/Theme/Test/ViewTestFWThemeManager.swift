import SwiftUI

public struct ViewTestFWThemeManager: View {
    @Environment(\.colorScheme) var colorScheme

    public init() {}

    public var body: some View {
        VStack {
            Text("Root View (ViewTestFWThemeManager)")
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding()
            NavigationLink("Go to Theme Demo View 1") {
                ThemeDemoView1()
            }
        }
        .background(colorScheme == .light ? Color.red : Color.green)
    }
}

struct ThemeDemoView1: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            Text("Theme Demo View 1")
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding()
            NavigationLink("Go to Theme Demo View 2") {
                ThemeDemoView2()
            }
        }
        .background(colorScheme == .light ? Color.red : Color.green)
    }
}

struct ThemeDemoView2: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            Text("Theme Demo View 2")
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding()
            NavigationLink("Go to Theme Demo View 3") {
                ThemeDemoView3()
            }
        }
        .background(colorScheme == .light ? Color.red : Color.green)
    }
}

struct ThemeDemoView3: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Text("Theme Demo View 3")
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .padding()
            .background(colorScheme == .light ? Color.red : Color.green)
    }
}
