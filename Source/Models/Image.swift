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
        if let highQuality = self.originalUrl4x {
            return URL(string: highQuality)
            
        } else if let mediumQuality = self.originalUrl3x {
            return URL(string: mediumQuality)
    
        }else if let normalQuality = self.originalUrl2x {
            return URL(string: normalQuality)
            
        }else if let lowQuality = self.originalUrl {
            return URL(string: lowQuality)
        }
        
        return nil
    }
    
}

extension Image: Equatable {
    static func == (lhs: Image, rhs: Image) -> Bool {
        return lhs.originalUrl == rhs.originalUrl
            && lhs.originalUrl2x == rhs.originalUrl2x
            && lhs.originalUrl3x == rhs.originalUrl3x
            && lhs.originalUrl4x == rhs.originalUrl4x
            && lhs.originalUrlPDF == rhs.originalUrlPDF
            && lhs.originalUrlSVG == rhs.originalUrlSVG
    }
}


extension Image: Hashable {
    
    func hash(into hasher: inout Hasher) {
        let originalURL = (originalUrl ?? "")
        let originalURL2x = (originalUrl2x ?? "")
        let originalURL3x = (originalUrl3x ?? "")
        let originalURL4x = (originalUrl4x ?? "")
        let originalURLPDF = (originalUrlPDF ?? "")
        let originalURLSVG = (originalUrlSVG ?? "")
        hasher.combine(originalURL)
        hasher.combine(originalURL2x  + originalURL3x  + originalURL4x)
        hasher.combine(originalURLPDF  + originalURLSVG)
    }
}
 
