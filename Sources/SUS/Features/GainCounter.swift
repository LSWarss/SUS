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
    func CalculateGainRatioForSingleAttribute(attribute: AttributesCountMap) throws -> Double
    func CalculateGainRatioForMultipleAttributes(attributes: [AttributesCountMap]) throws -> [Double]
}

struct GainCounterImpl: GainCounter {
    
    private let entropyCounter: EntropyCounter
    private let informationFunctionCounter: InformationFunctionCounter
    let decisionTreeTable: DecisionTreeTable
    
    init(entropyCounter: EntropyCounter,
         decisionTreeTable: DecisionTreeTable) {
        self.entropyCounter = entropyCounter
        self.decisionTreeTable = decisionTreeTable
        self.informationFunctionCounter = InformationFunctionCounterImpl(entropyCounter: entropyCounter)
    }
    
    func CalculateGainForMultipleAttributes(_ attributes: [AttributesCountMap]) throws -> [Double] {
        return try attributes.map { attribute in
            try CalculateGainForSingleAttribute(attribute)
        }
    }
    
    func CalculateGainForSingleAttribute(_ attribute: AttributesCountMap) throws -> Double {
//        let informationFunctionValue = try informationFunctionCounter.CalculateInformationFunctionForSingleAttribute(attribute)
//        return entropyCounter.CalculateEntropy(decisions: decisionTreeTable.decisionsCountMap) - informationFunctionValue
        return 0
    }
    
    func CalculateGainRatioForSingleAttribute(attribute: AttributesCountMap) throws -> Double {
        return try CalculateGainForSingleAttribute(attribute) / calculateSplitInfo(attribute)
    }
    
    func CalculateGainRatioForMultipleAttributes(attributes: [AttributesCountMap]) throws -> [Double] {
        return try attributes.map { attribute in
            try CalculateGainForSingleAttribute(attribute) / calculateSplitInfo(attribute)
        }
    }
}

extension GainCounterImpl {
    
    func calculateSplitInfo(_ attribute: AttributesCountMap) -> Double {
//        return entropyCounter.CalculateEntropy(decisions: attribute)
        return 0
    }
}
