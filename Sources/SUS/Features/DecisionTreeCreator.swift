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
        
        return DecisionTree(root: root)
    }
    
    private func createTree(node: inout Node) throws {
        let table = node.getDecisionTreeTable()
        
        if try getMaxRatio(for: table) == 0 {
            node.setLabel(node.getDecisionTreeTable().decisionsCountMap.first?.key ?? "")
            return
        }
        
        if node.getLabel() == "" {
            node.setLabel("\(try getIndexOfDiving(for: table))")
        }
        
        for attr in try getAttributeToDivideBy(for: table) {
            var child = Node(label: attr.key, decisionTable: table.getSubTable(for: attr.key))
            try createTree(node: &child)
            node.addChild(child)
        }
        
        SUSLogger.shared.info("Node: \(node.getLabel()) with children: \(node.getChildren())")
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


