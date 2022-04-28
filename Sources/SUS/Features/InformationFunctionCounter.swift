//
//  InformationFunctionCounter.swift
//  
//
//  Created by Łukasz Stachnik on 27/04/2022.
//

import Foundation

protocol InformationFunctionCounter {
    func CalculateInformationFunction(attributes: [AttributesMap]) throws -> [Double]
}

final class InformationFunctionCounterImpl: InformationFunctionCounter {
    
    let entropyCounter: EntropyCounter
    
    init(entropyCounter: EntropyCounter) {
        self.entropyCounter = entropyCounter
    }
    
    func CalculateInformationFunction(attributes: [AttributesMap]) throws -> [Double] {
        guard let decisions = attributes.last else {
            throw EntropyErrors.noDecisions
        }
        
        let attributesCount = entropyCounter.CalculateDecisionCount(decisions: decisions)
        
        let informationCounts: [Double] = []
//        for attribute in attributes {
//            if attributes.last
//            let count = attribute.value / attributesCount * entropyCounter.CalculateEntropy(attributes: <#T##[AttributesMap]#>)
//        }
        
        return [0]
    }
}

private extension InformationFunctionCounterImpl {
    
//    func calculateInformationFunction(attributes: AttributesMap, decisions: AttributesMap, attributesCount: Double) throws -> Double {
//        for attribute in attributes {
//            let entropy = try entropyCounter.CalculateEntropy(decisions: decisions)
//            let attribute.value / attributesCount * entropy
//        }
//    }
}
