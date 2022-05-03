//
//  DecisionTreeTable.swift
//  
//
//  Created by Łukasz Stachnik on 28/04/2022.
//

import Foundation

struct DecisionTreeTable: Equatable, Codable {
    var table: [[String]]
}

enum DecisionTreeTableError: Error {
    case emptyContent
}

// MARK: Functions
extension DecisionTreeTable {
    func getRowNumbersWithAttribute(_ attribute: String) -> [Int] {
        var rows: [Int] = []
        for i in 0..<attributes.count {
            if attributes[i].contains(attribute) {
                rows.append(i)
            }
        }
        
        return rows
    }
    
    func getDecisionsMapForAttribute(_ attribute: String) -> AttributesCountMap {
        let attributeRows = getRowNumbersWithAttribute(attribute)
        var map: AttributesCountMap = [:]
        for row in attributeRows {
            if !map.contains(where: { key, value in
                key == decisions[row]
            }) {
                map[decisions[row]] = 1
            } else {
                map[decisions[row]] = map[decisions[row]]!  + 1
            }
        }
        
        return map
    }
}

// MARK: Variables
extension DecisionTreeTable {
    
    var decisions: [String] {
        return table.map { $0.last ?? "" }
    }
 
    var attributes: [[String]] {
        return table.map { $0.dropLast() }
    }
    
    var decisionsCountMap: AttributesCountMap {
        var map: AttributesCountMap = [:]
        for decision in decisions {
            if let number = map[String(decision)] {
                map[String(decision)] = number + 1
            } else {
                map[String(decision)] = 1
            }
        }
        
        return map
    }
    
    var attributesCountMap: [AttributesCountMap] {
        var map: [AttributesCountMap] = []
        for attribute in attributes {
            for (i, attr) in attribute.enumerated() {
                if map.count <= i {
                    map.append([String(attr): 1])
                } else {
                    if let number = map[i][String(attr)] {
                        map[i][String(attr)] = number + 1
                    } else {
                        map[i][String(attr)] = 1
                    }
                }
            }
        }
        
        return map
    }
    
    var decisionsCount: Double {
        return Double(decisions.count)
    }
    
    var numberOfAttributes: Double {
        return Double(table.first?.dropLast().count ?? 0)
    }
}
