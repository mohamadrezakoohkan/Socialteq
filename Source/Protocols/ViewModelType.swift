//
//  ViewModelType.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/9/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

protocol ViewModelType {
  associatedtype Input
  associatedtype Output

  func transform(input: Input) -> Output
}
