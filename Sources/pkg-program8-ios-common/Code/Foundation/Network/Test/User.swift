//
//  User.swift
//  pkg-program8-ios-common
//
//  Created by Wattmonk21 on 29/07/25.
//


class User: Decodable, Identifiable,@unchecked Sendable {
    let id: Int
    var name: String
    let email: String
}
