//
//  DecisionTreeTable.swift
//  
//
//  Created by Łukasz Stachnik on 23/04/2022.
//

import Foundation

protocol DecisionTreeTableCreator {
    func CountAttributes() throws -> [AttributesCountMap]
    func CreateDecisionsTreeTable() -> DecisionTreeTable
}

final class DecisionTreeTableCreatorImpl: DecisionTreeTableCreator {
    
    private let content: String
    
    init(content: String) {
        self.content = content
    }
    
    func CreateDecisionsTreeTable() -> DecisionTreeTable {
        var table: [[String]] = []
        content.enumerateLines { line, stop in
            let temp = line.split(separator: ",").map { String($0) }
            table.append(temp)
        }
        
        return DecisionTreeTable(table: table)
    }
    
    func CountAttributes() throws -> [AttributesCountMap] {
        return createAttributesMapArray()
    }
}

private extension DecisionTreeTableCreatorImpl {
    
    func createAttributesMapArray() -> [AttributesCountMap] {
        var attributes: [AttributesCountMap] = []
        content.enumerateLines { line, stop in
            let temp = line.split(separator: ",")
            
            for (i, str) in temp.enumerated() {
                if attributes.count <= i {
                    attributes.append([String(str): 1])
                } else {
                    if let number = attributes[i][String(str)] {
                        attributes[i][String(str)] = number + 1
                    } else {
                        attributes[i][String(str)] = 1
                    }
                }
            }
        }
        
        return attributes
    }
}
