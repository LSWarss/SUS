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
        var decisionsCount: Double = 0
        for decision in decisions {
            decisionsCount += decision.value
        }
        
        return decisionsCount
    }
    
    func CalculateEntropyForAttribute(decisionTreeTable: DecisionTreeTable, attribute: String) -> Double {
        let decisions = decisionTreeTable.getDecisionsMapForAttribute(attribute)
        return CalculateEntropy(decisions: decisions)
    }
}

private extension EntropyCounterImpl {
    
    func calculateEntropy(decisions: AttributesCountMap) -> Double {
        let decisionsCount = CalculateDecisionCountFromAttributesMap(decisions)
        var entropy: Double = 0
        for decision in decisions {
            let p = Double(decision.value / decisionsCount)
            entropy += p * log2(p)
        }
        
        return -entropy
    }
}
