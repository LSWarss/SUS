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
    
    var decisionsCount: Double {
        return Double(decisions.count)
    }
    
    var numberOfAttributes: Double {
        return Double(table.first?.dropLast().count ?? 0)
    }
}
