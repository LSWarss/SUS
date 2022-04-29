//
//  GainCounter.swift
//  
//
//  Created by Łukasz Stachnik on 29/04/2022.
//

import Foundation

protocol GainCounter {
    func CalculateGain(attributes: [AttributesCountMap]) -> [Double]
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
    
    func CalculateGain(attributes: [AttributesCountMap]) -> [Double] {
        var tempGainValues: [Double] = []
        let infoFuncAttributesValues = informationFunctionCounter.CalculateInformationFunction(attributes: attributes)
        
        for i in 0..<Int(decisionTreeTable.numberOfAttributes) {
            tempGainValues.append(entropyCounter.CalculateEntropy(decisions: attributes.last ?? [:]) - infoFuncAttributesValues[i])
        }
        
        return tempGainValues
    }
}
