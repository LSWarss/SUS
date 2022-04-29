//
//  File.swift
//  
//
//  Created by Łukasz Stachnik on 29/04/2022.
//
import XCTest

@testable import SUS

final class GainCounterTests : XCTestCase {
    
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

    func testCalculateGain() throws {
        let gainCounter = GainCounterImpl(entropyCounter: entropyCounter, decisionTreeTable: testTable)
        let gotGains = gainCounter.CalculateGain(attributes: testAttributes)
        
        let wantGains = [0.6, 0.12451124978365313, 0.0]
        
        XCTAssertEqual(wantGains, gotGains)
    }
}
