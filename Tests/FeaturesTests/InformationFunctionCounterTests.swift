//
//  InformationFunctionCounterTests.swift
//  
//
//  Created by Łukasz Stachnik on 27/04/2022.
//

import XCTest

@testable import SUS

final class InformationFunctionCounterTests : XCTestCase {
    
    let testAttributes: [AttributesMap] = [["new": 3, "old": 3, "mid": 4], ["no": 6, "yes": 4], ["hwr": 4, "swr": 6], ["down": 5, "up": 5]]
    let failAttributes: [AttributesMap] = []
    let entropyCounter = EntropyCounterImpl()

    func testCalculateInformationFunction() throws {
        let informationFuncCounter = InformationFunctionCounterImpl(entropyCounter: entropyCounter)
        let informationValue = try informationFuncCounter.CalculateInformationFunction(attributes: testAttributes)
        let wantInformationValue = [0.4, 0.8754887502163469, 1.0]
        
        XCTAssertEqual(wantInformationValue, informationValue)
    }
}
