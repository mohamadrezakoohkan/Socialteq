//
//  User.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation


/// User represent actual end user that working with app
///
class User {
    
    static let shared: User = User()
    private init() { }
    
    @AppStorage(key: "user.name", defaultValue: String.guest.localized)
    var name: String?
    
    @AppStorage(key: "user.address", defaultValue: nil)
    var address: String?
    
    @AppStorage(key: "user.avatar", defaultValue: nil)
    var avatar: String?
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.name == rhs.name && lhs.address == rhs.address && lhs.avatar == rhs.avatar
    }
    
}

extension User: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine((name ?? "") + (address ?? "") + (avatar ?? ""))
    }
}
