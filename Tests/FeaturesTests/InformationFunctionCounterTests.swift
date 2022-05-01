//
//  InformationFunctionCounterTests.swift
//  
//
//  Created by Łukasz Stachnik on 27/04/2022.
//

import XCTest

@testable import SUS

final class InformationFunctionCounterTests : XCTestCase {
    
    let testAttributes: [AttributesCountMap] = [["new": 3, "old": 3, "mid": 4], ["no": 6, "yes": 4], ["hwr": 4, "swr": 6], ["down": 5, "up": 5]]
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
    let entropyCounter = EntropyCounterImpl()

    func testCalculateInformationFunctionForMultipleAttributes() throws {
        let informationFuncCounter = InformationFunctionCounterImpl(entropyCounter: entropyCounter, decisionTreeTable: testTable)
        let informationValue = try informationFuncCounter.CalculateInformationFunctionForMultipleAttributes(testAttributes)
        let wantInformationValue = [0.4, 0.8754887502163469, 1.0]
        
        XCTAssertEqual(wantInformationValue, informationValue)
    }
    
    func testCalculateInformationFunctionForNoAttributes() throws {
        let informationFuncCounter = InformationFunctionCounterImpl(entropyCounter: entropyCounter, decisionTreeTable: emptyTestTable)
        XCTAssertThrowsError(try informationFuncCounter.CalculateInformationFunctionForMultipleAttributes(failAttributes))
    }
    
    func testCalculateInformationForSingleAttribute() throws {
        let informationFuncCounter = InformationFunctionCounterImpl(entropyCounter: entropyCounter, decisionTreeTable: testTable)
        let informationValue = try informationFuncCounter.CalculateInformationFunctionForSingleAttribute(testAttributes.first!)
        let wantInformationValue: Double = 0.4
        
        XCTAssertEqual(wantInformationValue, informationValue)
    }
}
