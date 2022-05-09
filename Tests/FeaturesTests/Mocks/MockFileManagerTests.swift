//
//  File.swift
//  
//
//  Created by Łukasz Stachnik on 29/04/2022.
//
import XCTest

class MockFileManagerTests: XCTestCase {

    let mockFileManger = MockFileManager()
    
    func testContentInput() throws {
        mockFileManger.mockContent = "Test"
        let data = mockFileManger.contents(atPath: "Some path")
        XCTAssertEqual(String(data: data!, encoding: .utf8), "Test")
    }
}
