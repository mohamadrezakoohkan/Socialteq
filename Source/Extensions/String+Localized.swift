//
//  String+Localized.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

extension String {

    static var free: String { "free".localized }
    static var comma: String { "comma".localized }
    static var dot: String { "dot".localized }
    static var percentage: String { "percentage".localized }
    static var space: String { "space".localized }
    static var new: String { "new".localized }
    static var greeting: String { "greeting".localized }
    static var guest: String { "guest".localized }
    static var sampleUsername: String { "sample.username".localized }
    static var home: String { "home".localized }
    static var categories: String { "categories".localized }
    static var profile: String { "profile".localized }
    static var help: String { "help".localized }
    static var emptyString: String { "emptyString".localized }
    static var services: String { "services".localized }
    static var promotion: String { "promotion".localized }
    static var currency: String { "currency".localized }
    static var requestAddressMessage: String { "request.address.message".localized }
    static var eventAlternativeTitle: String { "event.alternative.title".localized }
    static var eventAlternativeSubTitle: String { "event.alternative.subTitle".localized }

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

}
