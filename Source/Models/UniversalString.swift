//
//  UniversalString.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

struct UniversalString: Codable, Multilingual {

    let en: String?
    let ar: String?

    var value: String? {
        return self.en
    }
}

extension UniversalString: Equatable {

    static func == (lhs: UniversalString, rhs: UniversalString) -> Bool {
        lhs.en == rhs.en && lhs.ar == rhs.ar
    }
}

extension UniversalString: Hashable {

    func hash(into hasher: inout Hasher) {
        hasher.combine((en ?? "") + (ar ?? ""))
    }
}
