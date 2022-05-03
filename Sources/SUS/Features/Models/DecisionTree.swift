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

struct DecisionTree: Codable {
    let root: Node
    
    func createDecisionTree(tableData: [[String]]) -> DecisionTree {
        let table = DecisionTreeTable(table: tableData)
        let root = Node(label: "", decisionTable: table)
        
        return DecisionTree(root: root)
    }
    
    mutating func createTree(node: Node) throws {
        let table = try node.getDecisionTable()
        
//        if table.
    }
}

private extension DecisionTree {
    
    func checkIfStopCondition() -> Bool {
        false   
    }
}

struct Node: Codable {
    private let label: String
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
}
