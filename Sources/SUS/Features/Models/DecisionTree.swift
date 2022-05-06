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

class DecisionTree: Codable, Equatable {
    static func == (lhs: DecisionTree, rhs: DecisionTree) -> Bool {
        lhs.root.getDecisionTreeTable() == rhs.root.getDecisionTreeTable()
    }
    
    init(root: Node) {
        self.root = root
    }
    
    let root: Node
}

class Node: Codable, Equatable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.label == rhs.label
    }
    
    private var label: String
    private let decisionTable: DecisionTreeTable?
    private var children: [Node]
    private var branchLabel: String?
    
    init(label: String, decisionTable: DecisionTreeTable) {
        self.label = label
        self.decisionTable = decisionTable
        self.children = []
    }
    
    func addChild(_ node: Node) {
        children.append(node)
    }
    
    func getChildren() -> [Node] {
        return children
    }
    
    func getDecisionTreeTable() -> DecisionTreeTable {
        return decisionTable ?? DecisionTreeTable(table: [])
    }
    
    func setLabel(_ text: String) {
        label = text
    }
    
    func setBranchLabel(_ text: String) {
        branchLabel = text
    }
    
    func getBranchLabel() -> String?{
        return branchLabel
    }
    
    func getLabel() -> String {
        return label
    }
    
    var isLeaf: Bool {
        return children.isEmpty
    }
    
    var isRoot: Bool {
        return branchLabel == ""
    }
}
