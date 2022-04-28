//
//  EntropyCounterTests.swift
//  FeaturesTests
//
//  Created by Łukasz Stachnik on 26/04/2022.
//

import XCTest

@testable import SUS

class EntropyCounterTests: XCTestCase {

    let testAttributes: [AttributesMap] = [["new": 3, "old": 3, "mid": 4], ["no": 6, "yes": 4], ["hwr": 4, "swr": 6], ["down": 5, "up": 5]]
    let failAttributes: [AttributesMap] = []
    let entopyCounter = EntropyCounterImpl()
    
    func testCalculateEntropy() throws {
        let entropyValue = try entopyCounter.CalculateEntropy(decisions: testAttributes.last ?? [:])
        let wantEntropyValue = 1.0
        
        XCTAssertEqual(wantEntropyValue, entropyValue)
    }
    
    func testCalculateEntropySmall() throws {
        let smallAttributes: AttributesMap = ["down": 3]
        
        let entropyValue = try entopyCounter.CalculateEntropy(decisions: smallAttributes)
        let wantEntropyValue = -0.0
        
        XCTAssertEqual(wantEntropyValue, entropyValue)
    }
    
    func testCalculateEntropyNoDecisionError() throws {
        do {
            let _ = try entopyCounter.CalculateEntropy(decisions: failAttributes.last ?? [:])
        } catch {
            XCTAssertEqual(error as! EntropyErrors, EntropyErrors.noDecisions)
        }
    }
    
    func testCalculateDecisionCount() throws {
        let decisions: AttributesMap = ["down": 5, "up": 5]
        
        let decisionCount = entopyCounter.CalculateDecisionCount(decisions: decisions)
        XCTAssertEqual(decisionCount, 10)
    }
}
