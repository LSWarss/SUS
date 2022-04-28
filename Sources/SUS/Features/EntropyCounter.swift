//
//  EntropyCounter.swift
//  
//
//  Created by Łukasz Stachnik on 26/04/2022.
//

import Foundation

protocol EntropyCounter {
    func CalculateEntropy(decisions: AttributesCountMap) -> Double
    func CalculateDecisionCount(decisions: AttributesCountMap) -> Double
}

final class EntropyCounterImpl: EntropyCounter {
    
    func CalculateEntropy(decisions: AttributesCountMap) -> Double {
        let decisionsCount = CalculateDecisionCount(decisions: decisions)
        return calculateEntropy(decisions: decisions, decisionsCount: decisionsCount)
    }
    
    func CalculateDecisionCount(decisions: AttributesCountMap) -> Double {
        var decisionsCount: Double = 0
        for decision in decisions {
            decisionsCount += decision.value
        }
        
        return decisionsCount
    }
}

private extension EntropyCounterImpl {
    
    func calculateEntropy(decisions: AttributesCountMap, decisionsCount: Double) -> Double {
        var entropy: Double = 0
        for decision in decisions {
            let p = Double(decision.value / decisionsCount)
            entropy += p * log2(p)
        }
        
        return -entropy
    }
}
