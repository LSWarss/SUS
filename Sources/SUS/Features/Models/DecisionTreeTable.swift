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
    case wrongGainRatioCalculation
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
    
    /**
     Returns number decisions with it's count for the given attribute string
     - Parameters:
        - attribute: Attribute key for which to count the number of decisions.
     - Returns: An array of decisions key with count of them. For instance: **["down": 5, "up": 5]**.
    */
    func getDecisionsCountMapForAttribute(_ attribute: String) -> AttributesCountMap {
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
    
    func getSubTable(indexes: [Int]) -> DecisionTreeTable {
        let subTable = indexes.map { table[$0] }
        return DecisionTreeTable(table: subTable)
    }
    
    func getSubTable(for attributeKey: String) -> DecisionTreeTable {
        let subTable = table.filter { $0.contains(attributeKey) }
        return DecisionTreeTable(table: subTable)
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
        for row in attributes {
            for i in 0..<row.count {
                if map.count <= i {
                    map.append([row[i]: 1])
                } else if let number = map[i][row[i]] {
                    map[i][row[i]] = number + 1
                } else {
                    map[i][row[i]] = 1
                }
            }
        }
        
        return map
    }
    
    var decisionsCount: Double {
        return Double(decisions.count)
    }
    
    var numberOfColumns: Double {
        return Double(table.first?.dropLast().count ?? 0)
    }
}
