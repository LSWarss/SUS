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
    
    func CreateDecisionTree(from treeTable: DecisionTreeTable) throws -> DecisionTree {
        var root = Node(label: "", decisionTable: treeTable)
        root.setBranchLabel("")
        try createTree(node: &root)
        
        return DecisionTree(root: root)
    }
    
    func Traverse(tree: DecisionTree) {
        traverseTree(node: tree.root, indent: "")
    }
    
    private func traverseTree(node: Node, indent: String) {
        if node.isLeaf {
            printLeaf(label: node.getLabel(), branchLabel: node.getBranchLabel() ?? "", indent: indent)
            return
        } else if node.isRoot {
            printRoot(label: node.getLabel())
        } else {
            printNode(label: node.getLabel(), branchLabel: node.getBranchLabel() ?? "", indent: indent)
        }
        
        for child in node.getChildren() {
            traverseTree(node: child, indent: indent + "\t")
        }
    }
    
    private func createTree(node: inout Node) throws {
        let table = node.getDecisionTreeTable()
        
        if try getMaxRatio(for: table) == 0 {
            node.setBranchLabel(node.getDecisionTreeTable().decisionsCountMap.first?.key ?? "")
            return
        }
        
        if node.getLabel() == "" {
            node.setLabel("\(try getIndexOfDiving(for: table))")
        }
        
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
    
    private func printLeaf(label: String, branchLabel: String, indent: String) {
        print("\(indent)\(label) -> \(branchLabel)")
    }
    
    private func printNode(label: String, branchLabel: String, indent: String) {
        print("\(indent)\(label) -> Attrybut \(branchLabel)")
    }
    
    private func printRoot(label: String) {
        print("Attrybut: \(label)")
    }
}


