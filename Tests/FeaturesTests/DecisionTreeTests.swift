//
//  DecisionTreeTests.swift
//  
//
//  Created by Łukasz Stachnik on 03/05/2022.
//

import XCTest

@testable import SUS

final class DecisionTreeTests: XCTestCase {
    
    let testingTable = [
        ["old", "yes", "swr", "down"],
        ["old", "no", "swr", "down"],
        ["old", "no", "hwr", "down"],
        ["mid", "yes", "swr", "down"],
        ["mid", "yes", "hwr", "down"],
        ["mid", "no", "hwr", "up"],
        ["mid", "no", "swr", "up"],
        ["new", "yes", "swr", "up"],
        ["new", "no", "hwr", "up"],
        ["new", "no", "swr", "up"]
    ]
    
    func testCreateDecisionTree() throws {
        let got = try DecisionTree.createDecisionTree(tableData: testingTable)
        let want: DecisionTree = DecisionTree(root: Node(label: "1", decisionTable: DecisionTreeTable(table: testingTable)))
        
        XCTAssertEqual(got, want)
    }
}
