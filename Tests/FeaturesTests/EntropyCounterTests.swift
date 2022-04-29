//
//  EntropyCounterTests.swift
//  FeaturesTests
//
//  Created by Łukasz Stachnik on 26/04/2022.
//

import XCTest

@testable import SUS

class EntropyCounterTests: XCTestCase {

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
    let entopyCounter = EntropyCounterImpl()
    
    func testCalculateEntropy() throws {
        let entropyValue = entopyCounter.CalculateEntropy(decisions: testAttributes.last ?? [:])
        let wantEntropyValue = 1.0
        
        XCTAssertEqual(wantEntropyValue, entropyValue)
    }
    
    func testCalculateEntropySmall() throws {
        let smallAttributes: AttributesCountMap = ["down": 3]
        
        let entropyValue = entopyCounter.CalculateEntropy(decisions: smallAttributes)
        let wantEntropyValue = -0.0
        
        XCTAssertEqual(wantEntropyValue, entropyValue)
    }
    
    func testCalculateDecisionCount() throws {
        let decisions: AttributesCountMap = ["down": 5, "up": 5]
        
        let decisionCount = entopyCounter.CalculateDecisionCountFromAttributesMap(decisions)
        XCTAssertEqual(decisionCount, 10)
    }
    
    func testCalculateEntropyForAttribute() throws {
        var attribute: String = "old"
        var entropy = entopyCounter.CalculateEntropyForAttribute(decisionTreeTable: testTable, attribute: attribute)
        XCTAssertEqual(entropy, 0.0)
        
        attribute = "mid"
        entropy = entopyCounter.CalculateEntropyForAttribute(decisionTreeTable: testTable, attribute: attribute)
        XCTAssertEqual(entropy, 1.0)
        
        attribute = "new"
        entropy = entopyCounter.CalculateEntropyForAttribute(decisionTreeTable: testTable, attribute: attribute)
        XCTAssertEqual(entropy, 0.0)
    }
}
