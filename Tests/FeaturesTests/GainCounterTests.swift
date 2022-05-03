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

    func testCalculateGainForMultipleAttributes() throws {
        let gainCounter = GainCounterImpl(entropyCounter: entropyCounter, decisionTreeTable: testTable)
        let gotGains = try gainCounter.CalculateGainForMultipleAttributes(testAttributes.dropLast())
        
        let wantGains = [0.6, 0.12451124978365313, 0.0]
        
        XCTAssertEqual(wantGains, gotGains)
    }
    
    func testCalculateGainForSingleAttribute() throws {
        let gainCounter = GainCounterImpl(entropyCounter: entropyCounter, decisionTreeTable: testTable)
        let got = try gainCounter.CalculateGainForSingleAttribute(testAttributes.first!)
        let want = 0.6
        
        XCTAssertEqual(got, want)
    }
    
    func testCalculateGainRatioForSingleAttribute() throws {
        let gainCounter = GainCounterImpl(entropyCounter: entropyCounter, decisionTreeTable: testTable)
        
        var got = try gainCounter.CalculateGainRatioForSingleAttribute(attribute: testAttributes.first!)
        var want = 0.3819343537078458
        XCTAssertEqual(got, want)
        
        got = try gainCounter.CalculateGainRatioForSingleAttribute(attribute: testAttributes[1])
        want = 0.12823644219877584
        XCTAssertEqual(got, want)
        
        got = try gainCounter.CalculateGainRatioForSingleAttribute(attribute: testAttributes[2])
        want = 0.0
        XCTAssertEqual(got, want)
    }
    
    func testCalculateGainRatioForMultipleAttributes() throws {
        let gainCounter = GainCounterImpl(entropyCounter: entropyCounter, decisionTreeTable: testTable)
        let got = try gainCounter.CalculateGainRatioForMultipleAttributes(attributes: testAttributes.dropLast())
        let want = [0.3819343537078458, 0.12823644219877584, 0.0]
        
        XCTAssertEqual(got, want)
    }
}
