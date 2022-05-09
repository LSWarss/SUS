//
//  InformationFunctionCounterTests.swift
//  
//
//  Created by Łukasz Stachnik on 27/04/2022.
//

import XCTest

@testable import SUS

final class InformationFunctionCounterTests : XCTestCase {
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
    let infCounter = InformationFunctionCounterImpl(entropyCounter: EntropyCounterImpl())

    func testCalculateInformationFunctionForAllAttributeColumns() throws {
        let got = try infCounter.CalculateInformationFunctionForAllAttributeColumns(in: testTable)
        let want = [0.4, 0.8754887502163469, 1.0]
        
        XCTAssertEqual(got, want)
    }
    
    func testCalculateInformationFunctionForAttributesMap() throws {
        var got = try infCounter.CalculateInformationFunctionForAttributesMap(testTable.attributesCountMap[0], in: testTable)
        var want = 0.4
        XCTAssertEqual(got, want)
        
        let subTable = testTable.getSubTable(for: "old")
        print(subTable.attributesCountMap)
        got = try infCounter.CalculateInformationFunctionForAttributesMap(subTable.attributesCountMap[0], in: subTable)
        want = 0.0
        XCTAssertEqual(got, want)
    }
    
    func testCalculateInformationFunctionForAllAttributeColumnsOnBigDataset() throws {
        guard let path = Bundle.module.path(forResource: "car", ofType: "data") else {
            XCTFail()
            return
        }
        let content = try fileReader.readFile(inputFilePath: path)
        let treeCreator = DecisionTreeTableCreatorImpl()
        let treeTable = try treeCreator.CreateDecisionsTreeTable(from: content)
        
        let got = preciseRound(try infCounter.CalculateInformationFunctionForAllAttributeColumns(in: treeTable), precision: .hundredths)
        let want: [Double] = [1.12, 1.12, 1.13, 1.17, 1.18, 1.26]
        
        SUSLogger.shared.info("Got: \(got) want \(want)")
        XCTAssertEqual(got, want)
    }
}
