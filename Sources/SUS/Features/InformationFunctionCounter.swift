//
//  InformationFunctionCounter.swift
//  
//
//  Created by Łukasz Stachnik on 27/04/2022.
//

import Foundation

protocol InformationFunctionCounter {
    func CalculateInformationFunction(attributes: [AttributesCountMap]) throws -> [Double]
}

final class InformationFunctionCounterImpl: InformationFunctionCounter {
    
    let entropyCounter: EntropyCounter
    let decisionTreeTable: DecisionTreeTable
    
    init(entropyCounter: EntropyCounter, decisionTreeTable: DecisionTreeTable) {
        self.entropyCounter = entropyCounter
        self.decisionTreeTable = decisionTreeTable
    }
    
    func CalculateInformationFunction(attributes: [AttributesCountMap]) throws -> [Double] {
        var temp: Double = 0
        var results: [Double] = []
        
        for attribute in attributes.dropLast() {
            for attr in attribute {
                temp += try calculateEntropyForAttribute(attr.key) * (attr.value / decisionTreeTable.decisionsCount)
            }
            results.append(temp)
            temp = 0
        }

        return results
    }
}

private extension InformationFunctionCounterImpl {
    
    /// Calculates entropy of decisions for given attribute in DecisionTreeTable
    func calculateEntropyForAttribute(_ attribute: String) throws -> Double {
        let decisions = decisionTreeTable.getDecisionsMapForAttribute(attribute)
        return entropyCounter.CalculateEntropy(decisions: decisions)
    }
}
