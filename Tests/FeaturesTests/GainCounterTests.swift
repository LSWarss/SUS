//
//  GainCounterTests.swift
//  
//
//  Created by Łukasz Stachnik on 29/04/2022.
//
import XCTest

@testable import SUS

final class GainCounterTests : XCTestCase {
    let fileReader = LocalFileReader()
    
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
        
        got = preciseRound(try gainCounter!.CalculateGainForSingleAttributesCountMap(testTable.attributesCountMap[1], in: testTable), precision: .hundredths)
        want = 0.12
        XCTAssertEqual(got, want, "Gain for second attribute of testTable should be 0.12")
        
        got = try gainCounter!.CalculateGainForSingleAttributesCountMap(testTable.attributesCountMap[2], in: testTable)
        want = 0.0
        XCTAssertEqual(got, want, "Gain for third attribute of testTable should be 0.0")
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
        var got = try gainCounter!.CalculateGainRatioForAttributesCountMapArray(attributesMapsArray: testTable.attributesCountMap, in: testTable)
        var want = [0.3819343537078458, 0.12823644219877584, 0.0]

        XCTAssertEqual(got.ratios, want)
        XCTAssertEqual(got.maxRatio, 0.3819343537078458)
        
        let table =  testTable.getSubTable(for: "mid")
        got = try gainCounter!.CalculateGainRatioForAttributesCountMapArray(attributesMapsArray: table.attributesCountMap, in: table)
        want = [0.0, 1.0, 0.0]
        XCTAssertEqual(got.ratios, want)
        XCTAssertEqual(got.maxRatio, 1.0)
    }
    
    func testCalculateGainRatioForMultipleAttributesOnBigDataset() throws {
        guard let path = Bundle.module.path(forResource: "car", ofType: "data") else {
            XCTFail()
            return
        }
        let content = try fileReader.readFile(inputFilePath: path)
        let treeCreator = DecisionTreeTableCreatorImpl()
        let treeTable = try treeCreator.CreateDecisionsTreeTable(from: content)
        SUSLogger.shared.info("Tree table: \(treeTable.attributesCountMap)")
        let got = try gainCounter!.CalculateGainRatioForAttributesCountMapArray(attributesMapsArray: treeTable.attributesCountMap, in: testTable)
        let want = [-0.00106517214711502, -0.00106517214711502, -0.00106517214711502, -0.0009895759401908056, -0.0009895759401908056, -0.0009895759401908056]
        SUSLogger.shared.info("Got: \(got.ratios) want \(want)")
        XCTAssertEqual(got.ratios, want)
        
        SUSLogger.shared.info("Got: \(got.maxRatio) want \( -0.0009895759401908056)")
        XCTAssertEqual(got.maxRatio,  -0.0009895759401908056)
    }
}
