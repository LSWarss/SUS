//
//  DecisionTree.swift
//  
//
//  Created by Łukasz Stachnik on 03/05/2022.
//

import Foundation

enum DecisionTreeError: Error {
    case noDecisionTable
}

struct DecisionTree: Codable, Equatable {
    let root: Node
    
    static func createDecisionTree(tableData: [[String]]) throws -> DecisionTree {
        let table = DecisionTreeTable(table: tableData)
        var root = Node(label: "", decisionTable: table)
        try createTree(node: &root)
        return DecisionTree(root: root)
    }
    
    private static func createTree(node: inout Node) throws {
        let table = try node.getDecisionTable()
    
        let maxGainRatio = try table.getMaxGainRatio()
        if maxGainRatio == 0 {
            node.setLabel("END")
            return
        }
        
        node.setLabel(String(try table.getAttributeToDivideBy().index))
        
        for att in try table.getAttributeToDivideBy().attributes {
            var child = Node(label: att.key, decisionTable: table.getSubTable(indexes: table.getRowNumbersWithAttribute(att.key)))
            node.addChild(child)
            try createTree(node: &child)
        }
    }
}

struct Node: Codable, Equatable{
    private var label: String
    private let decisionTable: DecisionTreeTable?
    private var children: [Node]
    
    init(label: String, decisionTable: DecisionTreeTable) {
        self.label = label
        self.decisionTable = decisionTable
        self.children = []
    }
    
    mutating func addChild(_ node: Node) {
        children.append(node)
    }
    
    func getDecisionTable() throws -> DecisionTreeTable {
        guard let decisionTable = decisionTable else {
            throw DecisionTreeError.noDecisionTable
        }

        return decisionTable
    }
    
    mutating func setLabel(_ text: String) {
        label = text
    }
}
