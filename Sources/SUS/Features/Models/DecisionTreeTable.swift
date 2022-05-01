//
//  DecisionTreeTable.swift
//  
//
//  Created by Łukasz Stachnik on 28/04/2022.
//

import Foundation

struct DecisionTreeTable: Equatable {
    var table: [[String]]
}

enum DecisionTreeTableError: Error {
    case emptyContent
}

extension DecisionTreeTable {
    
    var decisions: [String] {
        var decisions: [String] = []
        for row in table {
            decisions.append(row.last ?? "")
        }
        
        return decisions
    }
 
    var attributes: [[String]] {
        var attributes: [[String]] = []
        for row in table {
            attributes.append(row.dropLast())
        }
        
        return attributes
    }
    
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
    
    var decisionsMap: AttributesCountMap {
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
    
    var decisionsCount: Double {
        return Double(decisions.count)
    }
    
    var numberOfAttributes: Double {
        return Double(table.first?.dropLast().count ?? 0)
    }
}
