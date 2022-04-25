//
//  File.swift
//  
//
//  Created by Łukasz Stachnik on 23/04/2022.
//

import Foundation

protocol DecisionTreeTableCreator {
    func CreateDecisionTreeTable() throws -> String
}

typealias AttributesMap = [[String: Int]]

class DecisionTreeTableCreatorImpl: DecisionTreeTableCreator {
    
    private let fileWriter: FileWriter
    private let content: String
    
    init(fileWriter: FileWriter, content: String) {
        self.fileWriter = fileWriter
        self.content = content
    }
    
    func CreateDecisionTreeTable() throws -> String {
        let attributesMap: AttributesMap = createAttributesMap()
        var resultString = ""
        content.enumerateLines { line, stop in
            let temp = line.split(separator: ",")
            var tempString = ""
            for (i, str) in temp.enumerated() {
                print(str)
                
                let value = attributesMap[i].filter { $0.key == str }
                
                print(value)
                
                tempString += value.values.first?.description ?? ""
                
                if i != temp.count {
                    tempString += ","
                }
            }
            
            
            resultString.append("\(tempString)\n")
        }
        
        return resultString
    }
}

private extension DecisionTreeTableCreatorImpl {
    
    func createAttributesMap() -> AttributesMap {
        var attributes: [[String]] = []
        content.enumerateLines { line, stop in
            let temp = line.split(separator: ",")
            
            for (i, str) in temp.enumerated() {
                if attributes.count <= i {
                    attributes.append([String(str)])
                } else {
                    if attributes[i].contains(String(str)) {
                        continue
                    } else {
                        attributes[i].append(String(str))
                    }
                }
            }
        }
        
        let attributesMap: AttributesMap = attributes.map { attributesArray in
            var temp: [String: Int] = [:]
            
            for (i, attribute) in attributesArray.enumerated() {
                temp.updateValue((attributesArray.count - 1) - i, forKey: attribute)
            }
            
            return temp
        }
        
        return attributesMap
    }
}
