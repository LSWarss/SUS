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
    
    func testCalculateEntropy() throws {
        let entopyCounter = EntropyCounterImpl()
        
        let entropyValue = try entopyCounter.calculateEntropy(attributes: testAttributes)
        let wantEntropyValue = 1.0
        
        XCTAssertEqual(wantEntropyValue, entropyValue)
    }
}
