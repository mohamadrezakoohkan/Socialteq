//
//  Image.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/4/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation
import UIKit.UIDevice

struct Image: Codable, ImageSource  {
    
    let originalUrl: String?
    let originalUrl2x: String?
    let originalUrl3x: String?
    let originalUrl4x: String?
    let originalUrlPDF: String?
    let originalUrlSVG: String?
    
    enum CodingKeys: String, CodingKey {
        case originalUrl
        case originalUrl2x = "originalUrl@2x"
        case originalUrl3x = "originalUrl@3x"
        case originalUrl4x = "originalUrl@4x"
        case originalUrlPDF
        case originalUrlSVG
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.originalUrl = try container.decode(String?.self, forKey: .originalUrl)
        self.originalUrl2x = try? container.decode(String?.self, forKey: .originalUrl2x)
        self.originalUrl3x = try? container.decode(String?.self, forKey: .originalUrl3x)
        self.originalUrl4x = try? container.decode(String?.self, forKey: .originalUrl4x)
        self.originalUrlPDF = try? container.decode(String?.self, forKey: .originalUrlPDF)
        self.originalUrlSVG = try? container.decode(String?.self, forKey: .originalUrlSVG)
    }
}

extension Image: ImageUrlResolver {
    
    var imageURL: URL? {
        
        if let pdf = self.originalUrl {
            return URL(string: pdf)
            
        }else if UIDevice.current.isIpad,
            let ipadSize = self.originalUrl3x {
            return URL(string: ipadSize)
            
        }else if UIDevice.current.isIphone,
            let iphoneSize = self.originalUrl2x {
            return URL(string: iphoneSize)
            
        }else if let originalURL = self.originalUrl {
            return URL(string: originalURL)
            
        }else if let originalURL4x = self.originalUrl4x {
            return URL(string: originalURL4x)
        }
        
        return nil
    }
    
}
