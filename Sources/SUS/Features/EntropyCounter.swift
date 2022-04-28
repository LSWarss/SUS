//
//  EntropyCounter.swift
//  
//
//  Created by Łukasz Stachnik on 26/04/2022.
//

import Foundation

enum EntropyErrors: Error {
    case noDecisions
}

protocol EntropyCounter {
    func CalculateEntropy(decisions: AttributesMap) throws -> Double
    func CalculateDecisionCount(decisions: AttributesMap) -> Double
}

final class EntropyCounterImpl: EntropyCounter {
    
    func CalculateEntropy(decisions: AttributesMap) throws -> Double {
        let decisionsCount = CalculateDecisionCount(decisions: decisions)
        return calculateEntropy(decisions: decisions, decisionsCount: decisionsCount)
    }
    
    func CalculateDecisionCount(decisions: AttributesMap) -> Double {
        var decisionsCount: Double = 0
        for decision in decisions {
            decisionsCount += decision.value
        }
        
        return decisionsCount
    }
}

private extension EntropyCounterImpl {
    
    func calculateEntropy(decisions: AttributesMap, decisionsCount: Double) -> Double {
        var entropy: Double = 0
        for decision in decisions {
            let p = Double(decision.value / decisionsCount)
            entropy += p * log2(p)
        }
        
        return -entropy
    }
}
