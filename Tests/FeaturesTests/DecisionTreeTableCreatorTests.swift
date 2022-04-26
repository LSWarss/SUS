//
//  DecisionTreeTableCreatorTests.swift
//  
//
//  Created by Łukasz Stachnik on 23/04/2022.
//
import XCTest

@testable import SUS

final class DecisionTreeTableCreatorTests: XCTestCase {
    
    let mockFileManager: MockFileManager = MockFileManager()
    let testingTable: String = """
        old,yes,swr,down
        old,no,swr,down
        old,no,hwr,down
        mid,yes,swr,down
        mid,yes,hwr,down
        mid,no,hwr,up
        mid,no,swr,up
        new,yes,swr,up
        new,no,hwr,up
        new,no,swr,up
        """
    
    func testCountAttributes() throws {
        let mockFileWriter = LocalFileWriter(fileManager: mockFileManager)
        let creator = DecisionTreeTableCreatorImpl(fileWriter: mockFileWriter, content: testingTable)
            
        let wantAttributes: [AttributesMap] = [["new": 3, "old": 3, "mid": 4], ["no": 6, "yes": 4], ["hwr": 4, "swr": 6], ["down": 5, "up": 5]]
        let attributes = try creator.CountAttributes()
        
        XCTAssertEqual(wantAttributes, attributes)
    }
}

