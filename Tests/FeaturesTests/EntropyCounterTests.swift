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
        
        let decisionCount = entopyCounter.CalculateDecisionCount(decisions: decisions)
        XCTAssertEqual(decisionCount, 10)
    }
}
