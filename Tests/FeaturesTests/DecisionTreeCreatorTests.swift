//
//  DecisionTreeCreatorTests.swift
//  
//
//  Created by Łukasz Stachnik on 03/05/2022.
//

import XCTest

@testable import SUS

final class DecisionTreeCreatorTests: XCTestCase {
    let fileReader = LocalFileReader()
    
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
    
    func testCreateDecisionTreeOnBigDataset() throws {
        guard let path = Bundle.module.path(forResource: "car", ofType: "data") else {
            XCTFail()
            return
        }
        
        let content = try fileReader.readFile(inputFilePath: path)
        let treeCreator = DecisionTreeTableCreatorImpl()
        let treeTable = try treeCreator.CreateDecisionsTreeTable(from: content)
        let tree = try decisionTreeCreator!.CreateDecisionTree(from: treeTable)
        
        XCTAssertNoThrow(tree)
        
        decisionTreeCreator?.Traverse(tree: tree)
    }
    
    func testGetDividingAttrWithIndexes() throws {
        let treeTable = DecisionTreeTable(table: testingTable)
        let got = try decisionTreeCreator!.getDividingAttrWithIndexes(for: treeTable, indexOfDividing: 0)
        let want = [("new", [7, 8, 9]), ("old", [0,1, 2]), ("mid", [3, 4, 5, 6])]
        
        for got in got {
            let tempWant = want.first(where: { $0.0 == got.0 })
            XCTAssertEqual(got.0, tempWant!.0)
            XCTAssertEqual(got.1, tempWant!.1)
        }
    }
}
