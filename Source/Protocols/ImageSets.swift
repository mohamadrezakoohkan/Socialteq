//
//  ImageSets.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

protocol ImageSets {
    var originalUrl: String? { get }
    var originalUrl2x: String? { get }
    var originalUrl3x: String? { get }
    var originalUrl4x: String? { get }
    var originalUrlPDF: String? { get }
    var originalUrlSVG: String? { get }
}
