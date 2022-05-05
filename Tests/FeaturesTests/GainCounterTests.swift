//
//  GainCounterTests.swift
//  
//
//  Created by Łukasz Stachnik on 29/04/2022.
//
import XCTest

@testable import SUS

final class GainCounterTests : XCTestCase {
    
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
    
    var entropyCounter: EntropyCounter?
    var infCounter: InformationFunctionCounter?
    var gainCounter: GainCounter?
    
    override func setUp() async throws {
        entropyCounter = EntropyCounterImpl()
        infCounter = InformationFunctionCounterImpl(entropyCounter: entropyCounter!)
        gainCounter = GainCounterImpl(entropyCounter: entropyCounter!, informationFunctionCounter: infCounter!)
    }
    
    func testCalculateGainForSingleAttributesCountMap() throws {
        var got = try gainCounter!.CalculateGainForSingleAttributesCountMap(testTable.attributesCountMap[0], in: testTable)
        var want = 0.6
        XCTAssertEqual(got, want, "Gain for first attribute of testTable should be 0.6")
        
        got = try gainCounter!.CalculateGainForSingleAttributesCountMap(testTable.attributesCountMap[1], in: testTable)
        want = 0.12451124978365313
        XCTAssertEqual(got, want, "Gain for second attribute of testTable should be 0.6")
        
        got = try gainCounter!.CalculateGainForSingleAttributesCountMap(testTable.attributesCountMap[2], in: testTable)
        want = 0.0
        XCTAssertEqual(got, want, "Gain for third attribute of testTable should be 0.6")
    }
    
    func testCalculateGainRatioForSingleAttributesCountMap() throws {
        var got = try gainCounter!.CalculateGainRatioForSingleAttributesCountMap(testTable.attributesCountMap[0], in: testTable)
        var want = 0.3819343537078458
        XCTAssertEqual(got, want)

        got = try gainCounter!.CalculateGainRatioForSingleAttributesCountMap(testTable.attributesCountMap[1], in: testTable)
        want = 0.12823644219877584
        XCTAssertEqual(got, want)

        got = try gainCounter!.CalculateGainRatioForSingleAttributesCountMap(testTable.attributesCountMap[2], in: testTable)
        want = 0.0
        XCTAssertEqual(got, want)
    }
    
    func testCalculateSplitInfo() throws {
        let got = gainCounter!.CalculateSplitInfo(testTable.attributesCountMap[0], in: testTable)
        let want = 1.5709505944546684
        
        XCTAssertEqual(got, want)
    }
    

    func testCalculateGainRatioForMultipleAttributes() throws {
        let got = try gainCounter!.CalculateGainRatioForAttributesCountMapArray(attributesMapsArray: testTable.attributesCountMap, in: testTable)
        let want = [0.3819343537078458, 0.12823644219877584, 0.0]

        XCTAssertEqual(got.ratios, want)
        XCTAssertEqual(got.maxRatio, 0.3819343537078458)
    }
}
