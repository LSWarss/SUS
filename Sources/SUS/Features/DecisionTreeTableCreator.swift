//
//  DecisionTreeTable.swift
//  
//
//  Created by Łukasz Stachnik on 23/04/2022.
//

import Foundation

protocol DecisionTreeTableCreator {
    func CreateDecisionsTreeTable(from fileContent: String) throws -> DecisionTreeTable
}

struct DecisionTreeTableCreatorImpl: DecisionTreeTableCreator {
    
    func CreateDecisionsTreeTable(from fileContent: String) throws -> DecisionTreeTable {
        var table: [[String]] = []
        
        if fileContent.isEmpty {
            throw DecisionTreeTableError.emptyContent
        }
        
        fileContent.enumerateLines { line, stop in
            let temp = line.split(separator: ",").map { String($0) }
            table.append(temp)
        }
        
        return DecisionTreeTable(table: table)
    }
}
