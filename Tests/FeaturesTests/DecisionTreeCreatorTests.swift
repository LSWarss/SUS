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
        let got = try decisionTreeCreator?.CreateDecisionTree(from: DecisionTreeTable(table: testingTable))
        XCTAssertNoThrow(got)
        
        let rootNode = Node(label: "0", decisionTable: DecisionTreeTable(table: testingTable))
        let childerNew = Node(label: "new", decisionTable: DecisionTreeTable(table: testingTable).getSubTable(for: "new"))
        let childerOld = Node(label: "old", decisionTable: DecisionTreeTable(table: testingTable).getSubTable(for: "old"))
        let childerMid = Node(label: "mid", decisionTable: DecisionTreeTable(table: testingTable).getSubTable(for: "mid"))
        rootNode.addChild(childerNew)
        rootNode.addChild(childerOld)
        rootNode.addChild(childerMid)
        let childrenYes = Node(label: "yes", decisionTable: DecisionTreeTable(table: testingTable).getSubTable(for: "mid").getSubTable(for: "yes"))
        let childrenNo = Node(label: "no", decisionTable: DecisionTreeTable(table: testingTable).getSubTable(for: "mid").getSubTable(for: "no"))
        childerMid.addChild(childrenYes)
        childerMid.addChild(childrenNo)
        let want = DecisionTree(root: rootNode)
        
        XCTAssertEqual(got?.root.getLabel(), want.root.getLabel())
        XCTAssertEqual(got?.root.getChildren().count, 3)
        XCTAssertEqual(got?.root.getChildren().first { $0.getLabel() == "mid"}?.getChildren().count, 2)
        XCTAssertEqual(got?.root.getChildren().first { $0.getLabel() == "new"}?.getChildren().count, 0)
        XCTAssertEqual(got?.root.getChildren().first { $0.getLabel() == "old"}?.getChildren().count, 0)
        decisionTreeCreator?.Traverse(tree: got!)
    }
}
