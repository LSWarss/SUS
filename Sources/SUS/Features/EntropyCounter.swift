//
//  EntropyCounter.swift
//  
//
//  Created by Łukasz Stachnik on 26/04/2022.
//

import Foundation

protocol EntropyCounter {
    func CalculateEntropy(decisions: AttributesCountMap) -> Double
    func CalculateDecisionCountFromAttributesMap(_ decisions: AttributesCountMap) -> Double
    func CalculateEntropyForAttribute(decisionTreeTable: DecisionTreeTable, attribute: String) -> Double
}

struct EntropyCounterImpl: EntropyCounter {
    
    func CalculateEntropy(decisions: AttributesCountMap) -> Double {
        return calculateEntropy(decisions: decisions)
    }
    
    func CalculateDecisionCountFromAttributesMap(_ decisions: AttributesCountMap) -> Double {
        return decisions
            .map { $0.value }
            .reduce(0, +)
    }
    
    func CalculateEntropyForAttribute(decisionTreeTable: DecisionTreeTable, attribute: String) -> Double {
        let decisions = decisionTreeTable.getDecisionsMapForAttribute(attribute)
        return CalculateEntropy(decisions: decisions)
    }
}

private extension EntropyCounterImpl {
    
    func calculateEntropy(decisions: AttributesCountMap) -> Double {
        let decisionsCount = CalculateDecisionCountFromAttributesMap(decisions)
        let entropy = decisions
            .map { (Double($0.value) / decisionsCount) * log2(Double($0.value) / decisionsCount) }
            .reduce(0, +)

        return -entropy
    }
}
