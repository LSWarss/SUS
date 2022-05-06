//
//  GainCounter.swift
//  
//
//  Created by Łukasz Stachnik on 29/04/2022.
//

import Foundation

protocol GainCounter {
    func CalculateGainForSingleAttributesCountMap(_ attributesMap: AttributesCountMap, in treeTable: DecisionTreeTable) throws -> Double
    func CalculateGainRatioForSingleAttributesCountMap(_ attributesMap: AttributesCountMap, in treeTable: DecisionTreeTable) throws -> Double
    func CalculateGainRatioForAttributesCountMapArray(attributesMapsArray: [AttributesCountMap], in treeTable: DecisionTreeTable) throws -> (ratios: [Double], maxRatio: Double, maxRatioIndex: Int)
    func CalculateSplitInfo(_ attributesMap: AttributesCountMap, in treeTable: DecisionTreeTable) -> Double
}

struct GainCounterImpl: GainCounter {
    private let informationFunctionCounter: InformationFunctionCounter
    private let entropyCounter: EntropyCounter
    
    init(entropyCounter: EntropyCounter,
         informationFunctionCounter: InformationFunctionCounter) {
        self.entropyCounter = entropyCounter
        self.informationFunctionCounter = InformationFunctionCounterImpl(entropyCounter: entropyCounter)
    }
    
    /**
     Calculates Gain for single attribute count map, in given decision tree table. Which is subtract difference between decision class entropy and information function for given attribute map.
     - Parameters:
        - attributesMap: Single attribute count map for which to count the gain (for instace ["old": 3, "mid": 4, "new":3]
        - treeTable: Decisions Tree Table for which to calculate the decision class based entropy and inf functions.
     - Returns: Result in double of the gain calculation.
     */
    func CalculateGainForSingleAttributesCountMap(_ attributesMap: AttributesCountMap, in treeTable: DecisionTreeTable) throws -> Double {
        let informationFunctionValue = try informationFunctionCounter.CalculateInformationFunctionForAttributesMap(attributesMap, in: treeTable)
        return entropyCounter.CalculateEntropy(of: treeTable) - informationFunctionValue
    }
    
    /**
     Calculates Gain Ratio for single attribute count map, in given decision tree table. Which is gain devided by split info function result.
     - Parameters:
        - attributesMap: Single attribute count map for which to count the gain ratio (for instace ["old": 3, "mid": 4, "new":3]
        - treeTable: Decisions Tree Table for which to calculate the decision class based entropy and inf functions.
     - Returns: Result in double of the gain ratio calculation
     */
    func CalculateGainRatioForSingleAttributesCountMap(_ attributesMap: AttributesCountMap, in treeTable: DecisionTreeTable) throws -> Double {
        let gain = try CalculateGainForSingleAttributesCountMap(attributesMap, in: treeTable)
        let splitInfo = CalculateSplitInfo(attributesMap, in: treeTable)
        return gain == 0 ? 0 : gain / splitInfo
    }
    
    /**
     Calculates Gain Ratios for array of attribute count maps, in given decision tree table.
     - Parameters:
        - attributesMapsArray: Array fo attribute count maps for which to count the gain ratios (for instace ["old": 3, "mid": 4, "new":3]
        - treeTable: Decisions Tree Table for which to calculate the decision class based entropy and inf functions.
     - Returns: Result in array of doubles of the gain ratios calculation and max gain ratio of them all
     */
    func CalculateGainRatioForAttributesCountMapArray(attributesMapsArray: [AttributesCountMap], in treeTable: DecisionTreeTable) throws -> (ratios: [Double], maxRatio: Double, maxRatioIndex: Int) {
        let ratios = try attributesMapsArray
            .map { try CalculateGainRatioForSingleAttributesCountMap($0, in: treeTable) }
        
        let maxRatio = ratios.max() ?? 0
        let index = ratios.firstIndex { $0 == maxRatio }
        
        return (ratios, maxRatio, index ?? 0)
    }
    
    func CalculateSplitInfo(_ attributesMap: AttributesCountMap, in treeTable: DecisionTreeTable) -> Double {
        return -attributesMap
            .map { ($0.value / treeTable.decisionsCount) * (log2($0.value / treeTable.decisionsCount)) }
            .reduce(0, +)
    }
}
