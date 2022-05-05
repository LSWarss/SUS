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
    
    func getDecisionTreeTable() throws -> DecisionTreeTable {
        guard let decisionTable = decisionTable else {
            throw DecisionTreeError.noDecisionTable
        }

        return decisionTable
    }
    
    mutating func setLabel(_ text: String) {
        label = text
    }
    
    func getLabel() -> String {
        return label
    }
}
