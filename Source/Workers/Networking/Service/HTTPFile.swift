//
//  HTTPFile.swift
//  Socialteq
//
//  Created by Mohammad reza Koohkan on 5/10/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

struct HTTPFile {

    let manager: FileManager
    let url: URL
    let path: String

    var exist: Bool {
        return self.manager.fileExists(atPath: self.path)
    }

    init?(url value: URL?, fileManager: FileManager = .default) {
        guard let url = value else { return nil }
        self.init(url: url, fileManager: fileManager)

    }
    init(url: URL, fileManager: FileManager = .default) {
        var cacheDir = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let name = url.pathComponents.last ?? UUID().uuidString
        cacheDir.appendPathComponent(name)
        self.url = url
        self.manager = fileManager
        self.path = cacheDir.path
    }

    func write(from cache: String) throws {
        if self.exist {
           try self.remove()
        }
//        guard self.exist == false else { return }
        try manager.moveItem(atPath: cache, toPath: self.path)
    }

    func remove() throws {
        guard self.exist else { return }
        try manager.removeItem(at: URL(string: self.path)!)
    }

}
