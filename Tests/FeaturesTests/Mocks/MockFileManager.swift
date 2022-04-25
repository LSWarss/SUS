//
//  File.swift
//  
//
//  Created by Łukasz Stachnik on 23/04/2022.
//

import Foundation

class MockFileManager: FileManager {
    var mockContent: String = ""
    
    override func contents(atPath path: String) -> Data? {
        return mockContent.data(using: .utf8)
    }
}
