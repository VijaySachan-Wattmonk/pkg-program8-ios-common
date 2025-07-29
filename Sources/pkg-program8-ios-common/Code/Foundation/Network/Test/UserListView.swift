//
//  UserListView.swift
//  pkg-program8-ios-common
//
//  Created by Wattmonk21 on 29/07/25.
//


import SwiftUI

public struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()
public init() {}
    public var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                VStack(alignment: .leading) {
                    Text(user.name).font(.headline)
                    Text(user.email).font(.subheadline)
                }
            }
            .navigationTitle("Users")
            .onAppear {
                viewModel.fetchUsers()
            }
            .alert("Error", isPresented: $viewModel.isShowingAlert, actions: {
                Button("OK", role: .cancel) { }
            }, message: {
                Text(viewModel.alertMessage ?? "")
            })
        }
    }
}
