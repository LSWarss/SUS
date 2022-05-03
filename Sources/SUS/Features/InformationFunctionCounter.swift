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
        
        return try attributes.map {
            try CalculateInformationFunctionForSingleAttribute($0)
        }
    }
    
    func CalculateInformationFunctionForSingleAttribute(_ attribute: AttributesCountMap) throws -> Double {
        if attribute.isEmpty {
            throw AttributesCountMapError.emptyAttributesArray
        }
        
        return attribute
            .map { entropyCounter.CalculateEntropyForAttribute(decisionTreeTable: decisionTreeTable, attribute: $0.key) * ($0.value / decisionTreeTable.decisionsCount) }
            .reduce(0, +)
    }
}
