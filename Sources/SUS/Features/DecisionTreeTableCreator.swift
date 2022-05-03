//
//  DecisionTreeTable.swift
//  
//
//  Created by Łukasz Stachnik on 23/04/2022.
//

import Foundation

protocol DecisionTreeTableCreator {
    func CreateDecisionsTreeTable() throws -> DecisionTreeTable
}

struct DecisionTreeTableCreatorImpl: DecisionTreeTableCreator {
    
    private let content: String
    
    init(content: String) {
        self.content = content
    }
    
    func CreateDecisionsTreeTable() throws -> DecisionTreeTable {
        var table: [[String]] = []
        
        if content.isEmpty {
            throw DecisionTreeTableError.emptyContent
        }
        
        content.enumerateLines { line, stop in
            let temp = line.split(separator: ",").map { String($0) }
            table.append(temp)
        }
        
        return DecisionTreeTable(table: table)
    }
}
