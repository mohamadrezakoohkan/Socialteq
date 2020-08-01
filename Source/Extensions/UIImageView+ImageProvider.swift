//
//  UIImageView+ImageProvider.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/11/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

extension UIImageView: ImageProvider {
    

    func getImage(url: URL) -> AnyPublisher<String, Error> {
        return URLSession.shared
            .downloadTaskPublisher(for: url, cache: .returnCacheDataElseLoad, timeout: 60)
            .delay(for: 0.2, scheduler: DispatchQueue.main)
            .map({ _ in HTTPFile(url: url).path })
            .eraseToAnyPublisher()
    }
    
    func set(imageURL: URL?) -> AnyCancellable? {
        guard let url = imageURL else {
            self.image = .error
            return nil
        }
        
        let file = HTTPFile(url: url)
        
        if file.exist {
            return CurrentValueSubject<String, Never>.init(file.path)
                .map { UIImage(contentsOfFile: $0) }
                .receive(on: DispatchQueue.main)
                .assign(to: \.image, on: self)
        }else{
            return self.getImage(url: url)
                .map { UIImage(contentsOfFile: $0) }
                .replaceError(with: .error)
                .assign(to: \.image, on: self)
            
        }
    }
}
