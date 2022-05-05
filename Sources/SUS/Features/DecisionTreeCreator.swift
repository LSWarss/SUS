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
    
    func CreateDecisionTree(from tableData: [[String]]) throws -> DecisionTree {
        let treeTable = DecisionTreeTable(table: tableData)
        var root = Node(label: "", decisionTable: treeTable)
        try createTree(node: &root)
        
        SUSLogger.shared.info("Decision Tree root: \(root)")
        return DecisionTree(root: root)
    }
    
    private func createTree(node: inout Node) throws {
        let table = try node.getDecisionTreeTable()
        SUSLogger.shared.info("Decision Table of node: \(table)")
        
        let maxRatio = try getMaxRatio(for: table)
        if  maxRatio == 0 || maxRatio.isNaN {
            node.setLabel("Decision Class")
            SUSLogger.shared.info("Ending tree creation on node: \(node)")
            return
        }
        
        node.setLabel("\(try getIndexOfDiving(for: table))")
        
        for attr in try getAttributeToDivideBy(for: table) {
            var child = Node(label: attr.key, decisionTable: table.getSubTable(for: attr.key))
            node.addChild(child)
            try createTree(node: &child)
        }
    }
    
    
    private func getAttributeToDivideBy(for treeTable: DecisionTreeTable) throws -> AttributesCountMap {
        let (_, _, maxIndex) = try gainCounter.CalculateGainRatioForAttributesCountMapArray(attributesMapsArray: treeTable.attributesCountMap, in: treeTable)
        
        return treeTable.attributesCountMap[maxIndex]
    }
    
    private func getIndexOfDiving(for treeTable: DecisionTreeTable) throws -> Int {
        let (_, _, maxIndex) = try gainCounter.CalculateGainRatioForAttributesCountMapArray(attributesMapsArray: treeTable.attributesCountMap, in: treeTable)
        
        return maxIndex
    }
    
    private func getMaxRatio(for treeTable: DecisionTreeTable) throws -> Double {
        let (_, max, _) = try gainCounter.CalculateGainRatioForAttributesCountMapArray(attributesMapsArray: treeTable.attributesCountMap, in: treeTable)
        
        return max
    }
}


