//
//  DecisionTreeCreator.swift
//  
//
//  Created by Łukasz Stachnik on 05/05/2022.
//

import Foundation

struct DecisionTreeCreator {
    private let entropyCounter: EntropyCounter
    private let gainCounter: GainCounter
    private let informationFunctionCounter: InformationFunctionCounter
    
    init(entropyCounter: EntropyCounter) {
        self.entropyCounter = entropyCounter
        self.informationFunctionCounter = InformationFunctionCounterImpl(entropyCounter: entropyCounter)
        self.gainCounter = GainCounterImpl(entropyCounter: entropyCounter, informationFunctionCounter: informationFunctionCounter)
    }
    
    func createDecisionTree(from tableData: [[String]]) throws -> DecisionTree {
        let treeTable = DecisionTreeTable(table: tableData)
        var root = Node(label: "", decisionTable: treeTable)
        try createTree(node: &root)
        return DecisionTree(root: root)
    }
    
    private func createTree(node: inout Node) throws {
        let table = try node.getDecisionTreeTable()
    }
}


