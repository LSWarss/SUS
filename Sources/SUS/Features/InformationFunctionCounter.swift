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
    
    /**
     Calculates Information Function based on calculating entropy by decision classes, for all attribute columns in the given tree table.
     - Parameters:
        - treeTable: DecisionTreeTable of which attribute columns are going be be counted
     - Returns: Array of information function results for column
     */
    func CalculateInformationFunctionForAllAttributeColumns(in treeTable: DecisionTreeTable) throws -> [Double] {
        if treeTable.attributesCountMap.isEmpty {
            throw AttributesCountMapError.emptyAttributesArray
        }
        
        return try treeTable.attributesCountMap.map {
            try CalculateInformationFunctionForAttributesMap($0, in: treeTable)
        }
    }
    
    /**
     Calculates Information Function for given attribute count map.
     - Parameters:
        - attributeMap: Given attribute count map ( for instance ["old" : 3]) for which keys to calculate the information function.
        - treeTable: DecisionTreeTable of which attribute columns are going be be counted
     - Returns: Information function result
     */
    func CalculateInformationFunctionForAttributesMap(_ attributesMap: AttributesCountMap, in treeTable: DecisionTreeTable) throws -> Double {
        if attributesMap.isEmpty {
            throw AttributesCountMapError.emptyAttributesArray
        }
        
        return attributesMap
            .map {  ($0.value / treeTable.decisionsCount) * entropyCounter.CalculateEntropyForAttribute($0.key, in: treeTable) }
            .reduce(0, +)
    }
}
