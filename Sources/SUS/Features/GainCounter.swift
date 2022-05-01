//
//  GainCounter.swift
//  
//
//  Created by Łukasz Stachnik on 29/04/2022.
//

import Foundation

protocol GainCounter {
    func CalculateGainForMultipleAttributes(_ attributes: [AttributesCountMap]) throws -> [Double]
    func CalculateGainForSingleAttribute(_ attribute: AttributesCountMap) throws -> Double
    func CalculateGainRatio(attribute: AttributesCountMap) throws -> Double
}

struct GainCounterImpl: GainCounter {
    
    private let entropyCounter: EntropyCounter
    private let informationFunctionCounter: InformationFunctionCounter
    let decisionTreeTable: DecisionTreeTable
    
    init(entropyCounter: EntropyCounter,
         decisionTreeTable: DecisionTreeTable) {
        self.entropyCounter = entropyCounter
        self.decisionTreeTable = decisionTreeTable
        self.informationFunctionCounter = InformationFunctionCounterImpl(entropyCounter: entropyCounter,
                                                                         decisionTreeTable: decisionTreeTable)
    }
    
    func CalculateGainForMultipleAttributes(_ attributes: [AttributesCountMap]) throws -> [Double] {
        var tempGainValues: [Double] = []
        
        for i in 0..<Int(decisionTreeTable.numberOfAttributes) {
            tempGainValues.append(try CalculateGainForSingleAttribute(attributes[i]))
        }
        
        return tempGainValues
    }
    
    func CalculateGainForSingleAttribute(_ attribute: AttributesCountMap) throws -> Double {
        let informationFunctionValue = try informationFunctionCounter.CalculateInformationFunctionForSingleAttribute(attribute)
        
        return entropyCounter.CalculateEntropy(decisions: decisionTreeTable.decisionsMap) - informationFunctionValue
    }
    
    func CalculateGainRatio(attribute: AttributesCountMap) throws -> Double {
        return try CalculateGainForSingleAttribute(attribute) / calculateSplitInfo(attribute)
    }
}

extension GainCounterImpl {
    
    func calculateSplitInfo(_ attribute: AttributesCountMap) -> Double {
        return entropyCounter.CalculateEntropy(decisions: attribute)
    }
}
