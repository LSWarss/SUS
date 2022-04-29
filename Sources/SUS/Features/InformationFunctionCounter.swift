//
//  InformationFunctionCounter.swift
//  
//
//  Created by Łukasz Stachnik on 27/04/2022.
//

import Foundation

protocol InformationFunctionCounter {
    func CalculateInformationFunction(attributes: [AttributesCountMap]) -> [Double]
}

struct InformationFunctionCounterImpl: InformationFunctionCounter {
    
    private let entropyCounter: EntropyCounter
    var decisionTreeTable: DecisionTreeTable
    
    init(entropyCounter: EntropyCounter, decisionTreeTable: DecisionTreeTable) {
        self.entropyCounter = entropyCounter
        self.decisionTreeTable = decisionTreeTable
    }
    
    func CalculateInformationFunction(attributes: [AttributesCountMap]) -> [Double] {
        var tempInfFuncValue: Double = 0 // temporary information function value
        var attrResults: [Double] = []
        
        for attribute in attributes.dropLast() {
            for attr in attribute {
                tempInfFuncValue += entropyCounter.CalculateEntropyForAttribute(decisionTreeTable: decisionTreeTable, attribute: attr.key) * (attr.value / decisionTreeTable.decisionsCount)
            }
            attrResults.append(tempInfFuncValue)
            tempInfFuncValue = 0
        }

        return attrResults
    }
}
