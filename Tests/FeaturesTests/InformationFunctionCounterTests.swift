//
//  InformationFunctionCounterTests.swift
//  
//
//  Created by Łukasz Stachnik on 27/04/2022.
//

import XCTest

@testable import SUS

final class InformationFunctionCounterTests : XCTestCase {

    let testTable: DecisionTreeTable = DecisionTreeTable(table: [
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
    ])
    
    let failAttributes: [AttributesCountMap] = []
    let emptyTestTable: DecisionTreeTable = DecisionTreeTable(table: [])
    let infCounter = InformationFunctionCounterImpl(entropyCounter: EntropyCounterImpl())

    func testCalculateInformationFunctionForAllAttributeColumns() throws {
        let got = try infCounter.CalculateInformationFunctionForAllAttributeColumns(in: testTable)
        let want = [0.4, 0.8754887502163469, 1.0]
        
        XCTAssertEqual(got, want)
    }
    
    func testCalculateInformationFunctionForAttributesMap() throws {
        var got = try infCounter.CalculateInformationFunctionForAttributesMap(testTable.attributesCountMap[0], in: testTable)
        var want = 0.4
        XCTAssertEqual(got, want)
        
        let subTable = testTable.getSubTable(for: "old")
        print(subTable.attributesCountMap)
        got = try infCounter.CalculateInformationFunctionForAttributesMap(subTable.attributesCountMap[0], in: subTable)
        want = 0.0
        XCTAssertEqual(got, want)
    }
}
