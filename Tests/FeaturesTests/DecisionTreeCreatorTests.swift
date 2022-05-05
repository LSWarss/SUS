//
//  DecisionTreeCreatorTests.swift
//  
//
//  Created by Łukasz Stachnik on 03/05/2022.
//

import XCTest

@testable import SUS

final class DecisionTreeCreatorTests: XCTestCase {
    
    let testingTable = [
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
    ]
    
    var entropyCounter: EntropyCounter?
    var infCounter: InformationFunctionCounter?
    var gainCounter: GainCounter?
    var decisionTreeCreator: DecisionTreeCreator?
    
    override func setUp() async throws {
        entropyCounter = EntropyCounterImpl()
        decisionTreeCreator = DecisionTreeCreator(entropyCounter: entropyCounter!)
    }
    
    func testCreateDecisionTree() throws {
        let got = try decisionTreeCreator?.CreateDecisionTree(from: testingTable)
        XCTAssertNoThrow(got)
        
        var rootNode = Node(label: "0", decisionTable: DecisionTreeTable(table: testingTable))
        let childerNew = Node(label: "new", decisionTable: DecisionTreeTable(table: testingTable).getSubTable(for: "new"))
        let childerOld = Node(label: "old", decisionTable: DecisionTreeTable(table: testingTable).getSubTable(for: "old"))
        let childerMid = Node(label: "mid", decisionTable: DecisionTreeTable(table: testingTable).getSubTable(for: "mid"))
        rootNode.addChild(childerNew)
        rootNode.addChild(childerOld)
        rootNode.addChild(childerMid)
        let want = DecisionTree(root: rootNode)
        
        XCTAssertEqual(got?.root.getLabel(), want.root.getLabel())
        // TODO: Add more testing here
    }
}
