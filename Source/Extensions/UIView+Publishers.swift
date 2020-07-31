//
//  UIView+Publishers.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/8/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

extension UITextField {
    
    typealias KeyPathType<T> = KeyPath<UITextField, T>
    typealias PublishResult<T> = Publishers.MapKeyPath<Publishers.CompactMap<NotificationCenter.Publisher, UITextField>, T>
   
    enum ControlEvent {
        case didBegin
        case didEnd
        case didChanged
        
        var notification: Notification.Name {
            switch self {
            case .didBegin:
                return UITextField.textDidBeginEditingNotification
            case .didChanged:
                return UITextField.textDidChangeNotification
            case .didEnd:
                return UITextField.textDidEndEditingNotification
            }
        }
    }
    
    func publisher<T>(for keypath: KeyPathType<T>,
                      event: ControlEvent) -> PublishResult<T> {
        
        return NotificationCenter.default
            .publisher(for: event.notification)
            .compactMap { $0.object as? UITextField }
            .map(keypath)
    }
}

