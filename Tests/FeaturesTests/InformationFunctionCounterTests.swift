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

    func testCalculateInformationFunction() throws {
        let informationFuncCounter = InformationFunctionCounterImpl(entropyCounter: entropyCounter, decisionTreeTable: testTable)
        let informationValue = informationFuncCounter.CalculateInformationFunction(attributes: testAttributes)
        let wantInformationValue = [0.4, 0.8754887502163469, 1.0]
        
        XCTAssertEqual(wantInformationValue, informationValue)
    }
    
    func testCalculateInformationFunctionForEmpty() throws {
        let informationFuncCounter = InformationFunctionCounterImpl(entropyCounter: entropyCounter, decisionTreeTable: emptyTestTable)
        let informationValue = informationFuncCounter.CalculateInformationFunction(attributes: failAttributes)
        let wantInformationValue: [Double] = []
        
        XCTAssertEqual(wantInformationValue, informationValue)
    }
}
