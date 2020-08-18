//
//  User.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

protocol UserSource: User {
    var name: String? { get set }
    var address: String? { get set }
    var avatar: String? { get set }
}

/// User represent actual end user that working with app
///
class User: UserSource {

    static let shared: User = User()
    private init() { }

    @AppStorage(key: "user.name")
    var name: String?

    @AppStorage(key: "user.address")
    var address: String?

    @AppStorage(key: "user.avatar")
    var avatar: String?
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.name == rhs.name
            && lhs.address == rhs.address
            && lhs.avatar == rhs.avatar
    }

}

extension User: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine((name ?? .emptyString) + (address ?? .emptyString))
        hasher.combine(avatar)
    }
}
