//
//  InformationFunctionCounter.swift
//  
//
//  Created by Łukasz Stachnik on 27/04/2022.
//

import Foundation

protocol InformationFunctionCounter {
    func CalculateInformationFunctionForMultipleAttributes(_ attributes: [AttributesCountMap]) throws -> [Double]
    func CalculateInformationFunctionForSingleAttribute(_ attribute: AttributesCountMap) throws -> Double
}

struct InformationFunctionCounterImpl: InformationFunctionCounter {
    
    private let entropyCounter: EntropyCounter
    var decisionTreeTable: DecisionTreeTable
    
    init(entropyCounter: EntropyCounter, decisionTreeTable: DecisionTreeTable) {
        self.entropyCounter = entropyCounter
        self.decisionTreeTable = decisionTreeTable
    }
    
    func CalculateInformationFunctionForMultipleAttributes(_ attributes: [AttributesCountMap]) throws -> [Double] {
        if attributes.isEmpty {
            throw AttributesCountMapError.emptyAttributesArray
        }
        
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
    
    func CalculateInformationFunctionForSingleAttribute(_ attribute: AttributesCountMap) throws -> Double {
        if attribute.isEmpty {
            throw AttributesCountMapError.emptyAttributesArray
        }
        
        var tempInfFuncValue: Double = 0 // temporary information function value
        for attr in attribute {
            tempInfFuncValue +=  entropyCounter.CalculateEntropyForAttribute(decisionTreeTable: decisionTreeTable, attribute: attr.key) * (attr.value / decisionTreeTable.decisionsCount)
        }
        
        return tempInfFuncValue
    }
}
