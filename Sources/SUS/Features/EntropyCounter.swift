//
//  EntropyCounter.swift
//  
//
//  Created by Łukasz Stachnik on 26/04/2022.
//

import Foundation

protocol EntropyCounter {
    func CalculateEntropy(of treeTable: DecisionTreeTable) -> Double
    func CalculateEntropyForAttribute(_ attribute: String, in treeTable: DecisionTreeTable) -> Double
}

/**
 Entropy is a measure of disorder, the higher the entropy value, the higher the entropy value
 greater disorder and vice versa.
 */
struct EntropyCounterImpl: EntropyCounter {
    
    /**
     Calculates entropy for given decision tree table.
     - Returns: Entropy value in double. For instance for decisions counts: **["down": 5, "up": 5]**.it will be **1.0**.
     */
    func CalculateEntropy(of treeTable: DecisionTreeTable) -> Double {
        SUSLogger.shared.log(level: .info, "Attributes: \(treeTable.attributes.description)")
        
        let entropyValue = calculateEntropy(of: treeTable)
        return entropyValue
    }
    
    /**
     Calculates entropy for given attribute in given decision tree table.
     - Returns: Entropy value in double. For instance for decisions counts: **["down": 3]**.it will be **0.0**.
     */
    func CalculateEntropyForAttribute(_ attribute: String, in treeTable: DecisionTreeTable) -> Double {
        let subTable = treeTable.getSubTable(for: attribute)
        SUSLogger.shared.log(level: .info, "Attributes: \(subTable.attributes.description)")
        return calculateEntropy(of: subTable)
    }
}

private extension EntropyCounterImpl {
    
    func calculateEntropy(of treeTable: DecisionTreeTable) -> Double {
        SUSLogger.shared.log(level: .info, "Decisions Count Map: \(treeTable.decisionsCountMap)")
        let entropy = treeTable.decisionsCountMap
            .map { (Double($0.value) / treeTable.decisionsCount) * log2(Double($0.value) / treeTable.decisionsCount) }
            .reduce(0, +)
        SUSLogger.shared.log(level: .info, "Entropy: \(-entropy)")
        return -entropy
    }
}
