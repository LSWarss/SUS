//
//  String+FileTests.swift
//  
//
//  Created by Łukasz Stachnik on 21/04/2022.
//

import XCTest

@testable import SUS

final class String_FileTests: XCTestCase {

    let fileOne: String = "testingFile.jpg"
    let fileTwo: String = "TestingFile.txt"
    
    func testFileName() throws {
        XCTAssertEqual(fileOne.fileName(), "testingFile")
        XCTAssertEqual(fileTwo.fileName(), "TestingFile")
    }
    
    func testFileExtension() throws {
        XCTAssertEqual(fileOne.fileExtension(), "jpg")
        XCTAssertEqual(fileTwo.fileExtension(), "txt")
    }
}
