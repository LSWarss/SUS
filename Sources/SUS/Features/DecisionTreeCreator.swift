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
    
    private func createTree(node: inout Node) throws {
        let treeTable = node.getDecisionTreeTable()
        
        if try getMaxRatio(for: treeTable) == 0 {
            node.setBranchLabel(node.getDecisionTreeTable().decisionsCountMap.first?.key ?? "")
            return
        }
        
        let indexOfDividing = try getIndexOfDiving(for: treeTable)
        if node.getLabel() == "" {
            node.setLabel("\(indexOfDividing)")
        }
        
        for value in try getDividingAttrWithIndexes(for: treeTable, indexOfDividing: indexOfDividing) {
            var child = Node(label: value.0, decisionTable: treeTable.getSubTable(indexes: value.1))
            node.addChild(child)
            try createTree(node: &child)
        }
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
    
    func getDividingAttrWithIndexes(for treeTable: DecisionTreeTable, indexOfDividing: Int) throws -> [(String, [Int])] {
        let attributesToDivide = try getAttributeToDivideBy(for: treeTable)
        var indicies: [[Int]] = []
        
        for attr in attributesToDivide {
            var tempArray: [Int] = []
            for index in 0..<treeTable.table.count {
                if treeTable.table[index][indexOfDividing] == attr.key {
                    tempArray.append(index)
                }
            }
            indicies.append(tempArray)
            tempArray = []
        }
        
        
        let attrWithIndexes = zip(attributesToDivide.map { $0.key }, indicies).map { $0 }
        return attrWithIndexes
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


