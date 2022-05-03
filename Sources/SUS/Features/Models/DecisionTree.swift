//
//  DecisionTree.swift
//  
//
//  Created by Łukasz Stachnik on 03/05/2022.
//

import Foundation

struct DecisionTree: Codable {
    let root: Node
    
    func createDecisionTree(data: [Double]) {
        
    }
}

struct Node: Codable {
    private let label: String
    private var children: [Node]
    
    init(label: String) {
        self.label = label
        self.children = []
    }
    
    mutating func addChild(_ node: Node) {
        children.append(node)
    }
}
