//
//  InformationFunctionCounter.swift
//  
//
//  Created by Łukasz Stachnik on 27/04/2022.
//

import Foundation

protocol InformationFunctionCounter {
    func CalculateInformationFunctionForAllAttributeColumns(in treeTable: DecisionTreeTable) throws -> [Double]
    func CalculateInformationFunctionForAttributesMap(_ attributesMap: AttributesCountMap, in treeTable: DecisionTreeTable) throws -> Double
}

struct InformationFunctionCounterImpl: InformationFunctionCounter {
    private let entropyCounter: EntropyCounter
    
    init(entropyCounter: EntropyCounter) {
        self.entropyCounter = entropyCounter
    }
    
    func CalculateInformationFunctionForAllAttributeColumns(in treeTable: DecisionTreeTable) throws -> [Double] {
        if treeTable.attributesCountMap.isEmpty {
            throw AttributesCountMapError.emptyAttributesArray
        }
        
        return try treeTable.attributesCountMap.map {
            try CalculateInformationFunctionForAttributesMap($0, in: treeTable)
        }
    }
    
    func CalculateInformationFunctionForAttributesMap(_ attributesMap: AttributesCountMap, in treeTable: DecisionTreeTable) throws -> Double {
        if attributesMap.isEmpty {
            throw AttributesCountMapError.emptyAttributesArray
        }
        
        return attributesMap
            .map {  ($0.value / treeTable.decisionsCount) * entropyCounter.CalculateEntropyForAttribute($0.key, in: treeTable) }
            .reduce(0, +)
    }
}
