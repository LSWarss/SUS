//
//  File.swift
//  
//
//  Created by Łukasz Stachnik on 26/04/2022.
//

import Foundation

enum EntropyErrors: Error {
    case noDecisions
}

protocol EntropyCounter {
    func calculateEntropy(attributes: [AttributesMap]) throws -> Double
}

final class EntropyCounterImpl: EntropyCounter {
    
    func calculateEntropy(attributes: [AttributesMap]) throws -> Double {
        guard let decisions = attributes.last else {
            throw EntropyErrors.noDecisions
        }
        
        var decisionsCount: Double = 0
        for decision in decisions {
            decisionsCount += decision.value
        }
        
        var entropy: Double = 0
        for decision in decisions {
            let p = Double(decision.value / decisionsCount)
            entropy += p * log2(p)
        }
        
        return -entropy
    }
}
