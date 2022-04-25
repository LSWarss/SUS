//
//  FileWriterTests.swift
//  
//
//  Created by Łukasz Stachnik on 23/04/2022.
//

import XCTest

@testable import SUS

final class FileWriterTests: XCTestCase {
    
    let mockFileManager: MockFileManager = MockFileManager()

    func testLocalFileReader() throws {
        let content = "This is test"
        let writer = LocalFileWriter(fileManager: mockFileManager)
        
        XCTAssertNoThrow(try writer.writeToFile(fileName: "Test", content: content.data(using: .utf8)))
    }
}
